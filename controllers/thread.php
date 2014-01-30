<?php

	## ---------------------------------------------------
	#  ADDICTIVE COMMUNITY
	## ---------------------------------------------------
	#  Developed by Brunno Pleffken Hosti
	#  File: thread.php
	#  Release: v1.0.0
	#  Copyright: (c) 2014 - Addictive Software
	## ---------------------------------------------------
	
	// ---------------------------------------------------
	// Get thread ID
	// ---------------------------------------------------

	$threadId = Html::Request("id");

	// ---------------------------------------------------
	// What are we doing?
	// ---------------------------------------------------

	$act = Html::Request("act");

	if($act) {
		switch ($act) {
			case 'delete':
				# code...
				break;
			
			case 'setbestanswer':
				# code...
				break;

			case 'unsetbestanswer':
				# code...
				break;
		}
	}

	// ---------------------------------------------------
	// Fetch thread general info
	// ---------------------------------------------------

	$this->Db->Query("SELECT t.title, t.author_member_id, r.r_id, r.name,
		(SELECT COUNT(*) FROM c_posts p WHERE p.thread_id = t.t_id) AS post_count
		FROM c_threads t
		INNER JOIN c_rooms r ON (r.r_id = t.room_id)
		WHERE t.t_id = '{$threadId}';");

	$threadInfo = $this->Db->Fetch();

	// ---------------------------------------------------
	// Get thread number of pages
	// ---------------------------------------------------

	$itemsPerPage = $this->Core->config['thread_posts_per_page'];
	$totalPosts = $threadInfo['post_count'];
	
	// page number for SQL sentences
	$pSql	= (Html::Request("p")) ? Html::Request("p") * $itemsPerPage - $itemsPerPage : 0;

	// page number for HTML page numbers
	$pDisp = (isset($_REQUEST['p'])) ? $_REQUEST['p'] : 1;
	
	$pages = ceil($totalPosts / $itemsPerPage);

	// ---------------------------------------------------
	// Avoid incrementing visit counter in navigation
	// ---------------------------------------------------

	$_SERVER['HTTP_REFERER'] = (isset($_SERVER['HTTP_REFERER'])) ? $_SERVER['HTTP_REFERER'] : false;

	if(!strstr($_SERVER['HTTP_REFERER'], "module=thread")) {
		$this->Db->Query("UPDATE c_threads SET views = views + 1 WHERE t_id = '{$threadId}';");
	}

	// ---------------------------------------------------
	// Get first post
	// ---------------------------------------------------

	$this->Db->Query("SELECT c_posts.*, c_threads.t_id, c_threads.tags, c_threads.room_id,
		c_threads.title, c_threads.locked, c_members.* FROM c_posts
		INNER JOIN c_threads ON (c_posts.thread_id = c_threads.t_id)
		INNER JOIN c_members ON (c_posts.author_id = c_members.m_id)
		WHERE thread_id = '{$threadId}' AND first_post = '1' LIMIT 1;");

	$firstPostInfo = $this->Db->Fetch();

	// Format first thread

	$firstPostInfo['avatar'] = $this->Core->GetGravatar($firstPostInfo['email'], $firstPostInfo['photo'], 48, $firstPostInfo['photo_type']);
	$firstPostInfo['post_date'] = $this->Core->DateFormat($firstPostInfo['post_date']);

	// ---------------------------------------------------
	// Get replies
	// ---------------------------------------------------

	$this->Db->Query("SELECT c_posts.*, c_members.* FROM c_posts
		INNER JOIN c_members ON (c_posts.author_id = c_members.m_id)
		WHERE thread_id = '{$threadId}' AND first_post = '0'
		ORDER BY best_answer DESC,
		post_date ASC LIMIT {$pSql},{$itemsPerPage};");

	while($result = $this->Db->Fetch()) {

		// Is this a best answer or a regular reply?
		$result['bestanswer_class'] = ($result['best_answer'] == 1) ? "bestAnswer" : "";

		$result['avatar'] = $this->Core->GetGravatar($result['email'], $result['photo'], 96, $result['photo_type']);
		$result['joined'] = $this->Core->DateFormat($result['joined'], "short");
		$result['post_date'] = $this->Core->DateFormat($result['post_date']);

		if(isset($result['edited'])) {
			$result['edit_time'] = $this->Core->DateFormat($result['edit_time']);
			$result['edited'] = "<em>(Edited in " . $result['edit_time'] . " by " . $result['edit_author'] . ")</em>";
		}
		else {
			$result['edited'] = "";
		}

		$_replyResult[] = $result;
	}

	// ---------------------------------------------------
	// Pagination links
	// ---------------------------------------------------
	
	$paginationNav = "";
	
	if($pages != 0) {
		$paginationNav .= "<div class=\"pages\">Pages: ";
		
		// If it is not the first page, show link "Back"
		if($pDisp != 1) {
			$prev = $pDisp - 1;
			$paginationNav .= "<a href=\"index.php?module=thread&id={$threadId}&p={$prev}\">&laquo;</a>\n";
		}
		
		// Page numbers
		for($i = 1; $i <= $pages; $i++) {
			if($i == $pDisp) {
				$paginationNav .= "<a href=\"index.php?module=thread&id={$threadId}&p={$i}\" class=\"page-selected\">{$i}</a>\n";
			}
			else {
				$paginationNav .= "<a href=\"index.php?module=thread&id={$threadId}&p={$i}\">{$i}</a>\n";
			}
		}
		
		// If it is not the last page, show link "Next"
		if($pDisp != $i - 1) {
			$next = $pDisp + 1;
			$paginationNav .= "<a href=\"index.php?module=thread&id={$threadId}&p={$next}\">&raquo;</a>\n";
		}
		
		$paginationNav .= "</div>";
	}
	
	Template::Add($paginationNav);

	$pagination = Template::Get();
	Template::Clean();

	// ---------------------------------------------------
	// Do Related Threads list
	// ---------------------------------------------------

	$threadList = "";
	$threadSearch = explode(" ", String::Sanitize($firstPostInfo['title']));

	foreach($threadSearch as $key => $value) {
		if(strlen($value) < 4) {
			unset($threadSearch[$key]);
		}
	}

	$threadSearch = implode(" ", $threadSearch);

	$this->Db->Query("SELECT *, MATCH(title) AGAINST ('{$threadSearch}') AS relevance FROM c_threads
		WHERE t_id <> {$threadId} AND MATCH(title) AGAINST ('{$threadSearch}');");

	while($relatedThread = $this->Db->Fetch()) {
		$relatedThread['thread_date'] = $this->Core->DateFormat($relatedThread['lastpost_date'], "short");
		$_relatedThreadList[] = $relatedThread;

		//Template::Add($this->Core->DateFormat($relatedThread['start_date'], "short") . " - " . $relatedThread['title'] . " - " . $relatedThread['t_id']);
	}
	
	$threadList = Template::Get();
	Template::Clean();

	// ---------------------------------------------------
	// Where are we?
	// ---------------------------------------------------
	
	// Page information
	$pageinfo['title'] = $threadInfo['title'];
	$pageinfo['bc'] = array($threadInfo['name'], $threadInfo['title']);

?>
<?php

	## ---------------------------------------------------
	#  ADDICTIVE COMMUNITY
	## ---------------------------------------------------
	#  Developed by Brunno Pleffken Hosti
	#  File: profile.php
	#  Release: v1.0.0
	#  Copyright: (c) 2014 - Addictive Software
	## ---------------------------------------------------
	
	// ---------------------------------------------------
	// Which member are we seeing?
	// ---------------------------------------------------

	$id = Html::Request("id", true);

	// ---------------------------------------------------
	// Get member info
	// ---------------------------------------------------

	$this->Db->Query("SELECT c_members.*, c_usergroups.name, "
			. "(SELECT COUNT(*) FROM c_posts WHERE c_posts.author_id = c_members.m_id AND best_answer = 1) as bestanswers "
			. "FROM c_members LEFT JOIN c_usergroups ON (c_usergroups.g_id = c_members.usergroup) "
			. "WHERE m_id = '{$id}';");

	$info = $this->Db->Fetch();

	// Member avatar
	$info['avatar'] = $this->Core->GetGravatar($info['email'], $info['photo'], 160, $info['photo_type']);

	// Readable join date
	$info['joined'] = $this->Core->DateFormat($info['joined'], "short");

	// ---------------------------------------------------
	// Member profile subsections
	// ---------------------------------------------------

	$act = (Html::Request("act")) ? Html::Request("act") : "profile";

	switch($act) {

		// ---------------------------------------------------
		// Profile page
		// ---------------------------------------------------

		case "profile":


			// Birthday and age
			$info['birthday_timestamp'] = mktime(12, 0, 0, $info['b_month'], $info['b_day'], $info['b_year']);
			$info['birthday'] = $this->Core->DateFormat($info['birthday_timestamp'], "short");
			$info['age'] = $this->Core->MemberAge($info['birthday_timestamp']);

			// Member gender icon
			$info['gender'] = "<img src=\"" . $this->p['IMG'] . "/gender-{$info['gender']}.png\" alt=\"{$info['gender']}\">";

			// Location and Google Maps link
			$info['location_encoded'] = urlencode($info['location']);
			$info['location'] = "<a href=\"https://maps.google.com/maps?q={$info['location_encoded']}\" target=\"_blank\">{$info['location']}</a>";

			// Personal website link
			$info['website'] = "<a href=\"{$info['website']}\" rel=\"nofollow\" target=\"_blank\">{$info['website']}</a>";

			break;

		// ---------------------------------------------------
		// Posts and threads page
		// ---------------------------------------------------

		case "posts":

			// Select threads

			$this->Db->Query("SELECT t_id, title, start_date FROM c_threads "
					. "WHERE author_member_id = '{$info['m_id']}' AND approved = '1' "
					. "ORDER BY start_date DESC LIMIT 5;");

			while($threads = $this->Db->Fetch()) {
				$threads['start_date'] = $this->Core->DateFormat($threads['start_date'], "long");
				
				Template::Add ("<tr>
					<td class=\"tLabel\">{$threads['start_date']}</td>
					<td><a href=\"index.php?module=thread&amp;id={$threads['t_id']}\">{$threads['title']}</a></td>
				</tr>");
			}

			$threadList = Template::Get();
			Template::Clean();

			// Select posts

			$this->Db->Query("SELECT p.post_date, p.post, t.t_id, t.title FROM c_posts p "
					. "INNER JOIN c_threads t ON (t.t_id = p.thread_id) "
					. "WHERE author_id = '{$info['m_id']}' "
					. "ORDER BY post_date DESC LIMIT 5;");

			while($posts = $this->Db->Fetch()) {
				$posts['post_date'] = $this->Core->DateFormat($posts['post_date'], "long");
				
				Template::Add("<tr>
					<td class=\"tLabel\">{$posts['post_date']}</td>
					<td><a href=\"index.php?module=thread&amp;id={$posts['t_id']}\"><b>{$posts['title']}</b></a></td>
				</tr>
				<tr>
					<td colspan=\"2\" class=\"parsing\" style=\"border-bottom: 1px solid #eee; padding-left: 20px; padding-bottom: 20px\">
						{$posts['post']}
					</td>
				</tr>");
			}

			$postList = Template::Get();
			Template::Clean();

			break;

		// ---------------------------------------------------
		// Social networks updates
		// ---------------------------------------------------

		case "updates":
			break;
	}

	// ---------------------------------------------------
	// Where are we?
	// ---------------------------------------------------
	
	// Page information
	$pageinfo['title'] = "{$info['username']}";
	$pageinfo['bc'] = array("Profile: {$info['username']}");

?>
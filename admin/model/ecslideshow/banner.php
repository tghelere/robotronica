<?php
class ModelEcslideshowBanner extends Model {

	public function upgradeToLatest(){
		/*add custom cod field*/
		$query = $this->db->query("SELECT * FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '".DB_DATABASE."' AND TABLE_NAME = '".DB_PREFIX."ecbanner_image_description' AND COLUMN_NAME = 'custom_code'");
		if($query->num_rows <= 0){
			$query = $this->db->query("ALTER TABLE `".DB_DATABASE."`.`".DB_PREFIX."ecbanner_image_description` ADD COLUMN `custom_code` text");
		}
		/*add params field*/
		$query = $this->db->query("SELECT * FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '".DB_DATABASE."' AND TABLE_NAME = '".DB_PREFIX."ecbanner_image' AND COLUMN_NAME = 'params'");
		if($query->num_rows <= 0){
			$query = $this->db->query("ALTER TABLE `".DB_DATABASE."`.`".DB_PREFIX."ecbanner_image` ADD COLUMN `params` text");
		}

		/*add main width field*/
		$query = $this->db->query("SELECT * FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '".DB_DATABASE."' AND TABLE_NAME = '".DB_PREFIX."ecbanner' AND COLUMN_NAME = 'main_width'");
		if($query->num_rows <= 0){
			$query = $this->db->query("ALTER TABLE `".DB_DATABASE."`.`".DB_PREFIX."ecbanner` ADD COLUMN `main_width` int DEFAULT '0'");
		}

		/*add main height field*/
		$query = $this->db->query("SELECT * FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '".DB_DATABASE."' AND TABLE_NAME = '".DB_PREFIX."ecbanner' AND COLUMN_NAME = 'main_height'");
		if($query->num_rows <= 0){
			$query = $this->db->query("ALTER TABLE `".DB_DATABASE."`.`".DB_PREFIX."ecbanner` ADD COLUMN `main_height` int DEFAULT '0' ");
		}
	}
	public function installModule(){
		$sql = " SHOW TABLES LIKE '".DB_PREFIX."ecbanner'";
		$query = $this->db->query( $sql );
		if( count($query->rows) >0 ){
			$this->upgradeToLatest();
			return true;
		}

		$sql = array();

		$sql[] = "
				CREATE TABLE IF NOT EXISTS `".DB_PREFIX."ecbanner` (
				  `ecbanner_id` int(11) NOT NULL AUTO_INCREMENT,
				  `name` varchar(64) DEFAULT NULL,
				  `status` tinyint(4) DEFAULT NULL,
				  `main_width` int(11) DEFAULT '0',
				  `main_height` int(11) DEFAULT '0',
				  PRIMARY KEY (`ecbanner_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
		";
		$sql[] = "
				CREATE TABLE IF NOT EXISTS `".DB_PREFIX."ecbanner_image` (
				  `ecbanner_image_id` int(11) NOT NULL AUTO_INCREMENT,
				  `ecbanner_id` int(11) NOT NULL,
				  `link` varchar(255) DEFAULT NULL,
				  `image` varchar(255) DEFAULT NULL,
				  `product_id` int(11) DEFAULT NULL,
				  `ordering` int(11) DEFAULT 0,
				  `params` text(0) DEFAULT NULL,
				  PRIMARY KEY (`ecbanner_image_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
		";
		$sql[] = "CREATE TABLE IF NOT EXISTS `".DB_PREFIX."ecbanner_image_description` (
				  `ecbanner_image_id` int(11) NOT NULL,
				  `language_id` int(11) NOT NULL,
				  `ecbanner_id` int(11) DEFAULT NULL,
				  `title` varchar(100) DEFAULT NULL,
				  `description` text(0) DEFAULT NULL,
				  `custom_code` text(0) DEFAULT NULL,
				  PRIMARY KEY (`ecbanner_image_id`,`language_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;";
		
		foreach( $sql as $q ){
			$query = $this->db->query( $q );
		}
		return true;
	}
	public function addBanner($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "ecbanner SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "', main_width=".(int)$data['main_width'].", main_height=".(int)$data['main_height']);

		$banner_id = $this->db->getLastId();

		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $banner_image) {

				$params = isset($banner_image['params'])?$banner_image['params']:"";
				if( is_array($params) || is_object($params) ) {
					$params = serialize($params);
				}

				$this->db->query("INSERT INTO " . DB_PREFIX . "ecbanner_image SET ecbanner_id = '" . (int)$banner_id . "', link = '" .  $this->db->escape($banner_image['link']) . "', image = '" .  $this->db->escape($banner_image['image']) . "', params='".$this->db->escape($params)."', ordering='".$this->db->escape($banner_image['ordering'])."', product_id=".(int)$banner_image['product_id']);

				$banner_image_id = $this->db->getLastId();
				$banner_image['banner_image_description'] = (isset($banner_image['language']) && $banner_image['language'])?$banner_image['language']:$banner_image['banner_image_description'];

				foreach ($banner_image['banner_image_description'] as $language_id => $banner_image_description) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "ecbanner_image_description SET ecbanner_image_id = '" . (int)$banner_image_id . "', language_id = '" . (int)$language_id . "', ecbanner_id = '" . (int)$banner_id . "', title = '" .  $this->db->escape($banner_image_description['title']) . "', description = '" .  $this->db->escape($banner_image_description['description']) . "', custom_code = '" .  $this->db->escape($banner_image_description['custom_code'])."'");
				}
			}
		}
		return $banner_id;
	}

	public function editBanner($banner_id, $data) {

		$this->db->query("UPDATE " . DB_PREFIX . "ecbanner SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "', main_width=".(int)$data['main_width'].", main_height=".(int)$data['main_height']." WHERE ecbanner_id = '" . (int)$banner_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "ecbanner_image WHERE ecbanner_id = '" . (int)$banner_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "ecbanner_image_description WHERE ecbanner_id = '" . (int)$banner_id . "'");

		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $banner_image) {
				$params = isset($banner_image['params'])?serialize($banner_image['params']):"";
				$this->db->query("INSERT INTO " . DB_PREFIX . "ecbanner_image SET ecbanner_id = '" . (int)$banner_id . "', link = '" .  $this->db->escape($banner_image['link']) . "', image = '" .  $this->db->escape($banner_image['image']) . "', params='".$this->db->escape($params)."',  ordering='".$this->db->escape($banner_image['ordering'])."', product_id=".(int)$banner_image['product_id']);

				$banner_image_id = $this->db->getLastId();

				foreach ($banner_image['banner_image_description'] as $language_id => $banner_image_description) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "ecbanner_image_description SET ecbanner_image_id = '" . (int)$banner_image_id . "', language_id = '" . (int)$language_id . "', ecbanner_id = '" . (int)$banner_id . "', title = '" .  $this->db->escape($banner_image_description['title']) . "', description = '" .  $this->db->escape($banner_image_description['description']) . "', custom_code = '" .  $this->db->escape($banner_image_description['custom_code'])."'");
				}
			}
		}
		return $banner_id;
	}

	public function deleteBanner($banner_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "ecbanner WHERE ecbanner_id = '" . (int)$banner_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "ecbanner_image WHERE ecbanner_id = '" . (int)$banner_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "ecbanner_image_description WHERE ecbanner_id = '" . (int)$banner_id . "'");
	}

	public function getBanner($banner_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "ecbanner WHERE ecbanner_id = '" . (int)$banner_id . "'");

		return $query->row;
	}

	public function getBanners($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "ecbanner";

		$sort_data = array(
			'name',
			'status'
		);
		$sql .= ' WHERE 1 ';

	    if(isset($data['filter_status'])){
	        $sql .= " AND `status`=".(int)$data['filter_status'];
	    }
	    if(isset($data['filter_id'])){
	        $sql .= " AND `ecbanner_id` IN (".implode(",", $data['filter_id']).")";
	    }
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY name";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getBannerImages($banner_id) {
		$banner_image_data = array();

		$banner_image_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ecbanner_image WHERE ecbanner_id = '" . (int)$banner_id . "' ORDER BY ordering");

		foreach ($banner_image_query->rows as $banner_image) {
			$banner_image_description_data = array();

			$banner_image_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ecbanner_image_description WHERE ecbanner_image_id = '" . (int)$banner_image['ecbanner_image_id'] . "' AND ecbanner_id = '" . (int)$banner_id . "'");

			foreach ($banner_image_description_query->rows as $banner_image_description) {
				$banner_image_description_data[$banner_image_description['language_id']] = array('title' => $banner_image_description['title'],'description' => $banner_image_description['description'],
					'custom_code' => $banner_image_description['custom_code']);
			}

			$banner_image_data[] = array(
				'banner_image_description' => $banner_image_description_data,
				'link'                     => $banner_image['link'],
        		'product_id'               => $banner_image['product_id'],
        		'ordering'				   => $banner_image['ordering'],
        		'params'				   => $banner_image['params'],
				'image'                    => $banner_image['image']
			);
		}

		return $banner_image_data;
	}

	public function getTotalBanners() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "ecbanner");

		return $query->row['total'];
	}

	public function getImportBanners( $data = array(), $header = array()) {
		$banners = array();
		if($data && $header ) {
			foreach($data as $banner) {
				if($banner) {
					$banner_info = array();
					$images = array();
					foreach ($banner as $key=> $val) {
						$field_name = isset($header[ $key ])?trim($header[ $key ]):"";

						switch ($field_name) {
							case 'name':
								$banner_info['name'] = $val;
								break;
							case 'status':
								$banner_info['status'] = $val;
								break;
							case 'main_width':
								$banner_info['main_width'] = $val;
								break;
							case 'main_height':
								$banner_info['main_height'] = $val;
								break;
							default:
								
								$tmp = explode("__", $field_name);
								if(count($tmp) == 3) {

									$images[ $tmp[1] ][ $tmp[2] ] = $val;

								} else if(count($tmp) == 5) {

									$images[ $tmp[1] ][ $tmp[2] ][ $tmp[3] ][ $tmp[4] ] = $val;

								}
								break;
						}
					}
					$banner_info["banner_image"] = $images;
					$banners[] = $banner_info;
				}
			}
		}

		return $banners;
	}
	public function importBanners( $data = array() ) {
		if($data) {

			return true;
		}
		return false;
	}
	public function array2csv(array &$array)
	{
	   if (count($array) == 0) {
	     return null;
	   }
	   ob_start();
	   $df = fopen("php://output", 'w');
	   fputcsv($df, array_keys(reset($array)));
	   foreach ($array as $row) {
	      fputcsv($df, $row);
	   }
	   fclose($df);
	   return ob_get_clean();
	}
}
?>

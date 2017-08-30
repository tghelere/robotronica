<?php
class ModelEcslideshowBanner extends Model {	
	public function getBanner($banner_id, $limit_banner = 50, $random = 0) {
		$limit = "";
		$orderby = " ORDER BY bi.ordering";
		if(!empty($limit_banner)){
			$limit = " LIMIT ".$limit_banner;
		}
		if($random){
			$orderby = " ORDER BY RAND()";
		}
		$data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ecbanner_image bi LEFT JOIN " . DB_PREFIX . "ecbanner_image_description bid ON (bi.ecbanner_image_id  = bid.ecbanner_image_id) WHERE bi.ecbanner_id = '" . (int)$banner_id . "' AND bid.language_id = '" . (int)$this->config->get('config_language_id') . "'".$orderby.$limit);
		$data['banners'] = $query->rows;

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ecbanner WHERE ecbanner_id = " . (int)$banner_id );
		$data['banner_info'] = $query->row;
		return $data;
	}
}
?>
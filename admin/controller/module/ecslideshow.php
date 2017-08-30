<?php
/******************************************************
 * @package Camera Slideshow for Opencart 1.5.x
 * @version 1.0
 * @author EcomTeck (http://ecomteck.com)
 * @copyright	Copyright (C) May 2013 ecomteck.com <@emai:ecomteck@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

class ControllerModuleEcslideshow extends Controller {
	private $error = array();

	public function index() {

		$this->language->load('module/ecslideshow');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		$this->load->model('ecslideshow/banner');

		$this->model_ecslideshow_banner->installModule();

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$action = isset($this->request->post["action"])?$this->request->post["action"]:"";
			
			if(!empty($this->request->post['ecslideshow_module'])){
				foreach($this->request->post['ecslideshow_module'] as $key=>$module){
					$custom_position = isset($module['custom_position'])?$module["custom_position"]:"";
					if(!empty($custom_position)){
						$this->request->post['ecslideshow_module'][$key]['position'] = $custom_position;	
					}
					
				}
			}
			
			$this->model_setting_setting->editSetting('ecslideshow', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			if($action == "save_stay"){
				$this->redirect($this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'], 'SSL'));
			}else{
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}

		}
		$this->document->addScript('view/javascript/ecslideshow/color_picker/js/colpick.js');
		$this->document->addStyle('view/javascript/ecslideshow/color_picker/css/colpick.css');
		$this->document->addStyle('view/stylesheet/ecslideshow.css');
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_header_top'] = $this->language->get('text_header_top');
		$this->data['text_header_bottom'] = $this->language->get('text_header_bottom');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
        $this->data['text_footer_top'] = $this->language->get('text_footer_top');
		$this->data['text_footer_bottom'] = $this->language->get('text_footer_bottom');
        $this->data['text_alllayout'] = $this->language->get('text_alllayout');
		$this->data['text_default'] = $this->language->get('text_default');

		$this->data['entry_content'] = $this->language->get('entry_content');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_custom_position'] = $this->language->get('entry_custom_position');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_save_stay'] = $this->language->get('button_save_stay');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_new_block'] = $this->language->get('button_add_new_block');
		$this->data['text_alllayout'] = $this->language->get('text_all_layout');
		$this->data['link_to_module'] = $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['link_to_banner'] = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'], 'SSL');



		$this->data['tab_block'] = $this->language->get('tab_block');

		$this->data['resiztypes'] = array(''=>$this->language->get('text_default'),
										 'default'=>$this->language->get('text_white_space'),
										 'w'=>$this->language->get("text_resize_width"),
										 'h'=>$this->language->get("text_resize_height"));

		$this->data['positions'] = array(
										  'content_top',
										  'content_bottom',
										  'column_left',
										  'column_right'
		);
		$this->data['caption_effects'] = array('moveFromLeft',
										'moveFomRight',
										'moveFromTop',
										'moveFromBottom',
										'fadeIn',
										'fadeFromLeft',
										'fadeFromRight',
										'fadeFromTop',
										'fadeFromBottom');

   	 	$this->data['skins'] = array("camera_amber_skin",
								"camera_ash_skin",
								"camera_azure_skin",
								"camera_beige_skin",
								"camera_black_skin",
								"camera_blue_skin",
								"camera_brown_skin",
								"camera_burgundy_skin",
								"camera_charcoal_skin",
								"camera_chocolate_skin",
								"camera_coffee_skin",
								"camera_cyan_skin",
								"camera_fuchsia_skin",
								"camera_gold_skin",
								"camera_green_skin",
								"camera_grey_skin",
								"camera_indigo_skin",
								"camera_khaki_skin",
								"camera_lime_skin",
								"camera_magenta_skin",
								"camera_maroon_skin",
								"camera_orange_skin",
								"camera_olive_skin",
								"camera_pink_skin",
								"camera_pistachio_skin",
								"camera_red_skin",
								"camera_tangerine_skin",
								"camera_turquoise_skin",
								"camera_violet_skin",
								"camera_white_skin",
								"camera_yellow_skin");
   		$this->data['alignments'] = array("topLeft",
									"topCenter",
									"topRight",
									"centerLeft",
									"center",
									"centerRight",
									"bottomLeft",
									"bottomCenter",
									"bottomRight");
   		$this->data['directions'] = array("leftToRight",
   											"rightToLeft",
   											"topToBottom",
   											"bottomToTop");
   		$this->data['bar_positions'] = array("left","right","top","bottom");
   		$this->data['easings'] = array('linear',
   										'swing',
   										'easeInQuad',
   										'easeOutQuad',
   										'easeInOutQuad',
   										'easeInCubic',
   										'easeOutCubic',
   										'easeInOutCubic',
   										'easeInQuart',
   										'easeOutQuart',
   										'easeInOutQuart',
   										'easeInQuint',
   										'easeOutQuint',
   										'easeInOutQuint',
   										'easeInExpo',
   										'easeOutExpo',
   										'easeInOutExpo',
   										'easeInSine',
   										'easeOutSine',
   										'easeInOutSine',
   										'easeInCirc',
   										'easeOutCirc',
   										'easeInOutCirc',
   										'easeInElastic',
   										'easeOutElastic',
   										'easeInOutElastic',
   										'easeInBack',
   										'easeOutBack',
   										'easeInOutBack',
   										'easeInBounce',
   										'easeOutBounce',
   										'easeInOutBounce'
   										);
   		$fx = "random,simpleFade,curtainTopLeft,curtainTopRight,curtainBottomLeft,curtainBottomRight,curtainSliceLeft,curtainSliceRight,blindCurtainTopLeft,blindCurtainTopRight,blindCurtainBottomLeft,blindCurtainBottomRight,blindCurtainSliceBottom,blindCurtainSliceTop,stampede,mosaic,mosaicReverse,mosaicRandom,mosaicSpiral,mosaicSpiralReverse,topLeftBottomRight,bottomRightTopLeft,bottomLeftTopRight,bottomLeftTopRight,scrollLeft,scrollRight,scrollHorz,scrollBottom,scrollTop";

   		$this->data['effects'] = explode(",",$fx);
   		$loaders = "pie,bar,none";
   		$this->data['loaders'] = explode(",",$loaders);
   		$this->data['yesno'] = array('1'=>$this->language->get("text_yes"),
   									 "0"=>$this->language->get("text_no"));
		$this->load->model('localisation/language');
   		$languages = $this->model_localisation_language->getLanguages();
		$this->data['languages'] = $languages;

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['dimension'])) {
			$this->data['error_dimension'] = $this->error['dimension'];
		} else {
			$this->data['error_dimension'] = array();
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();

		if (isset($this->request->post['ecslideshow_module'])) {
			$this->data['modules'] = $this->request->post['ecslideshow_module'];
		} elseif ($this->config->get('ecslideshow_module')) {
			$this->data['modules'] = $this->config->get('ecslideshow_module');
		}

    $this->data['default'] = $this->defaultConfig(array());
    if( !empty($this->data['modules'])){
        foreach($this->data['modules'] as $key=>$module){
            $this->data['modules'][$key] = $this->defaultConfig($module);
        }

    }
		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->load->model('setting/store');

		$this->data['stores'] = $this->model_setting_store->getStores();

		$this->load->model('ecslideshow/banner');
    $data = array("filter_status"=>1);
		$this->data['banners'] = $this->model_ecslideshow_banner->getBanners($data);

		$this->template = 'module/ecslideshow/module.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	public function banner(){
		$this->language->load('module/ecslideshow');

		$this->document->setTitle($this->language->get('heading_banner_title'));

		$this->load->model('ecslideshow/banner');

		$this->model_ecslideshow_banner->installModule();

		$this->data['link_to_module'] = $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['link_to_banner'] = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'], 'SSL');

		$this->getList();
	}
	public function insert_banner(){
		$this->language->load('module/ecslideshow');
		$this->document->setTitle($this->language->get('heading_banner_title'));

		$this->load->model('ecslideshow/banner');

		$this->data['link_to_module'] = $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['link_to_banner'] = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'], 'SSL');

		$this->model_ecslideshow_banner->installModule();

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$action = isset($this->request->post['action'])?$this->request->post['action']: 'save_stay';

			$banner_id = $this->model_ecslideshow_banner->addBanner($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			if($action == "save_stay"){
				$this->redirect($this->url->link('module/ecslideshow/update_banner', 'ecbanner_id='.$banner_id.'&token=' . $this->session->data['token'] . $url, 'SSL'));
			}else{
				$this->redirect($this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
			
		}

		$this->getForm();
	}
	public function update_banner(){
		$this->language->load('module/ecslideshow');

		$this->document->setTitle($this->language->get('heading_banner_title'));

		$this->load->model('ecslideshow/banner');
		$this->data['link_to_module'] = $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['link_to_banner'] = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'], 'SSL');

		$this->model_ecslideshow_banner->installModule();

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$action = isset($this->request->post['action'])?$this->request->post['action']: 'save_stay';

			$banner_id = $this->model_ecslideshow_banner->editBanner($this->request->get['ecbanner_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			if($action == "save_stay"){
				$this->redirect($this->url->link('module/ecslideshow/update_banner', 'ecbanner_id='.$banner_id.'&token=' . $this->session->data['token'] . $url, 'SSL'));
			}else{
				$this->redirect($this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
			
		}

		$this->getForm();
	}
	public function delete_banner(){
		$this->language->load('module/ecslideshow');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('ecslideshow/banner');

		$this->model_ecslideshow_banner->installModule();

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $banner_id) {
				$this->model_ecslideshow_banner->deleteBanner($banner_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			$this->redirect($this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}
	protected function getList(){
		$this->document->addStyle('view/stylesheet/ecslideshow.css');
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
      $this->data['breadcrumbs'][] = array(
          'text'      => $this->language->get('heading_banner_title'),
          'href'      => $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] . $url, 'SSL'),
          'separator' => ' :: '
      );

		$this->data['insert'] = $this->url->link('module/ecslideshow/insert_banner', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('module/ecslideshow/delete_banner', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['export'] = $this->url->link('module/ecslideshow/exportcsv', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['import'] = $this->url->link('module/ecslideshow/importcsv', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['banners'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);

		$banner_total = $this->model_ecslideshow_banner->getTotalBanners();

		$results = $this->model_ecslideshow_banner->getBanners($data);

		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('module/ecslideshow/update_banner', 'token=' . $this->session->data['token'] . '&ecbanner_id=' . $result['ecbanner_id'] . $url, 'SSL')
			);

			$this->data['banners'][] = array(
				'ecbanner_id' => $result['ecbanner_id'],
				'name'      => $result['name'],
				'status'    => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'selected'  => isset($this->request->post['selected']) && in_array($result['ecbanner_id'], $this->request->post['selected']),
				'action'    => $action
			);
		}

		$this->data['heading_title'] = $this->language->get('heading_banner_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_export'] = $this->language->get('button_export');
		$this->data['button_import'] = $this->language->get('button_import');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['sort_name'] = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] . '&sort=status' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		$this->load->model('localisation/language');
   		$languages = $this->model_localisation_language->getLanguages();
		$this->data['languages'] = $languages;

		$pagination = new Pagination();
		$pagination->total = $banner_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'module/ecslideshow/banner_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	protected function getForm(){
		$this->document->addStyle('view/stylesheet/ecslideshow.css');
		$this->data['heading_title'] = $this->language->get('heading_banner_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_link'] = $this->language->get('entry_link');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_status'] = $this->language->get('entry_status');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_banner'] = $this->language->get('button_add_banner');
		$this->data['button_remove'] = $this->language->get('button_remove');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else if (isset($this->session->data['error']) && isset($this->session->data['error']['warning'])) {
			$this->data['error_warning'] = $this->session->data['error']['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}

 		if (isset($this->error['banner_image'])) {
			$this->data['error_banner_image'] = $this->error['banner_image'];
		} else {
			$this->data['error_banner_image'] = array();
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

      $this->data['breadcrumbs'][] = array(
          'text'      => $this->language->get('heading_title'),
          'href'      => $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'] . $url, 'SSL'),
          'separator' => ' :: '
      );
      $this->data['breadcrumbs'][] = array(
          'text'      => $this->language->get('heading_banner_title'),
          'href'      => $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] . $url, 'SSL'),
          'separator' => ' :: '
      );

		if (!isset($this->request->get['ecbanner_id'])) {
			$this->data['action'] = $this->url->link('module/ecslideshow/insert_banner', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('module/ecslideshow/update_banner', 'token=' . $this->session->data['token'] . '&ecbanner_id=' . $this->request->get['ecbanner_id'] . $url, 'SSL');
		}

		$this->data['cancel'] = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['ecbanner_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$banner_info = $this->model_ecslideshow_banner->getBanner($this->request->get['ecbanner_id']);
		}

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($banner_info)) {
			$this->data['name'] = $banner_info['name'];
		} else {
			$this->data['name'] = '';
		}

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($banner_info)) {
			$this->data['status'] = $banner_info['status'];
		} else {
			$this->data['status'] = true;
		}

		if (isset($this->request->post['main_width'])) {
			$this->data['main_width'] = $this->request->post['main_width'];
		} elseif (!empty($banner_info)) {
			$this->data['main_width'] = $banner_info['main_width'];
		} else {
			$this->data['main_width'] = "";
		}

		if (isset($this->request->post['main_height'])) {
			$this->data['main_height'] = $this->request->post['main_height'];
		} elseif (!empty($banner_info)) {
			$this->data['main_height'] = $banner_info['main_height'];
		} else {
			$this->data['main_height'] = "";
		}

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->data['caption_alignment'] = array(
												"moveFromLeft",
												"moveFomRight",
												"moveFromTop",
												"moveFromBottom",
												"fadeIn",
												"fadeFromLeft",
												"fadeFromRight",
												"fadeFromTop",
												"fadeFromBottom");
		$this->data['image_alignments'] = array("topLeft",
									"topCenter",
									"topRight",
									"centerLeft",
									"center",
									"centerRight",
									"bottomLeft",
									"bottomCenter",
									"bottomRight");

   		$this->data['easings'] = array('linear',
   										'swing',
   										'easeInQuad',
   										'easeOutQuad',
   										'easeInOutQuad',
   										'easeInCubic',
   										'easeOutCubic',
   										'easeInOutCubic',
   										'easeInQuart',
   										'easeOutQuart',
   										'easeInOutQuart',
   										'easeInQuint',
   										'easeOutQuint',
   										'easeInOutQuint',
   										'easeInExpo',
   										'easeOutExpo',
   										'easeInOutExpo',
   										'easeInSine',
   										'easeOutSine',
   										'easeInOutSine',
   										'easeInCirc',
   										'easeOutCirc',
   										'easeInOutCirc',
   										'easeInElastic',
   										'easeOutElastic',
   										'easeInOutElastic',
   										'easeInBack',
   										'easeOutBack',
   										'easeInOutBack',
   										'easeInBounce',
   										'easeOutBounce',
   										'easeInOutBounce'
   										);
   		$fx = "random,simpleFade,curtainTopLeft,curtainTopRight,curtainBottomLeft,curtainBottomRight,curtainSliceLeft,curtainSliceRight,blindCurtainTopLeft,blindCurtainTopRight,blindCurtainBottomLeft,blindCurtainBottomRight,blindCurtainSliceBottom,blindCurtainSliceTop,stampede,mosaic,mosaicReverse,mosaicRandom,mosaicSpiral,mosaicSpiralReverse,topLeftBottomRight,bottomRightTopLeft,bottomLeftTopRight,bottomLeftTopRight,scrollLeft,scrollRight,scrollHorz,scrollBottom,scrollTop";

   		$this->data['effects'] = explode(",",$fx);

   		$this->data['yesno'] = array('1'=>$this->language->get("text_yes"),
   									 "0"=>$this->language->get("text_no"));

		$this->load->model('tool/image');

		if (isset($this->request->post['banner_image'])) {
			$banner_images = $this->request->post['banner_image'];
		} elseif (isset($this->request->get['ecbanner_id'])) {
			$banner_images = $this->model_ecslideshow_banner->getBannerImages($this->request->get['ecbanner_id']);
		} else {
			$banner_images = array();
		}

		$this->data['banner_images'] = array();

		foreach ($banner_images as $banner_image) {
			if ($banner_image['image'] && file_exists(DIR_IMAGE . $banner_image['image'])) {
				$image = $banner_image['image'];
			} else {
				$image = 'no_image.jpg';
			}

			$this->data['banner_images'][] = array(
				'banner_image_description' => $banner_image['banner_image_description'],
        		'product_id'               => $banner_image['product_id'],
				'link'                     => $banner_image['link'],
				'image'                    => $image,
				'ordering'				   => $banner_image['ordering'],
				'params'				   => is_array($banner_image['params'])?$banner_image['params']:unserialize($banner_image['params']),
				'thumb'                    => $this->model_tool_image->resize($image, 100, 100)
			);
		}


		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);

		$this->template = 'module/ecslideshow/banner_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	public function importcsv() {

		$this->language->load('module/ecslideshow');
		$this->load->model('ecslideshow/banner');
		$this->document->addStyle('view/stylesheet/ecslideshow.css');

		$this->document->setTitle($this->language->get('heading_import_banner_title'));

		$this->model_ecslideshow_banner->installModule();

		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {

			//Upload File
			if (is_uploaded_file($_FILES['file']['tmp_name'])) {
				$this->data['message'] = "<h1>" . "File ". $_FILES['file']['name'] ." uploaded successfully." . "</h1>";
				$this->data['message'] .= "<h2>Import to Database:</h2>";
				//readfile($_FILES['file']['tmp_name']);
			}

			//Import uploaded file to Database
			$tmp = array();
			$header = array();
			$banners = array();
			$handle = fopen($_FILES['file']['tmp_name'], "r");
			$i = 0;
			while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
				if($i == 0 && !empty($data)) {
					$header = $data;
				} else {
					$tmp[] = $data;
				}
				$i++;
				
			}

			fclose($handle);

			if($tmp) {

				$banners = $this->model_ecslideshow_banner->getImportBanners( $tmp, $header );
				
				if($banners) {
					foreach ($banners as $banner) {
						if($banner_id = $this->model_ecslideshow_banner->addBanner($banner)) {
							$this->data['message'] .= "Imported <b>'".$banner['name']."'</b> Done.<br/>";
						} else {
							$this->data['message'] .= "Imported <b>'".$banner['name']."'</b> Error.<br/>";
						}
					}
				}
				
			}

			//view upload form

		}

		$this->data['heading_title'] = $this->language->get('heading_import_banner_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');
		$this->data['text_help_import'] = $this->language->get('text_help_import');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_link'] = $this->language->get('entry_link');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_status'] = $this->language->get('entry_status');


		$this->data['button_import'] = $this->language->get('button_import');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_banner'] = $this->language->get('button_add_banner');
		$this->data['button_remove'] = $this->language->get('button_remove');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else if (isset($this->session->data['error']) && isset($this->session->data['error']['warning'])) {
			$this->data['error_warning'] = $this->session->data['error']['warning'];
		} else {
			$this->data['error_warning'] = '';
		}


		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

      $this->data['breadcrumbs'][] = array(
          'text'      => $this->language->get('heading_title'),
          'href'      => $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'], 'SSL'),
          'separator' => ' :: '
      );
      $this->data['breadcrumbs'][] = array(
          'text'      => $this->language->get('heading_banner_title'),
          'href'      => $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'] , 'SSL'),
          'separator' => ' :: '
      );

      	$this->data['link_to_module'] = $this->url->link('module/ecslideshow', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['link_to_banner'] = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['action'] = $this->url->link('module/ecslideshow/importcsv', 'token=' . $this->session->data['token'] , 'SSL');

		$this->data['cancel'] = $this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];

		$this->template = 'module/ecslideshow/import_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}
	public function exportcsv() {
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {

			$this->download_send_headers("ecslideshow_data_export_" . date("Y-m-d") . ".csv");
			$this->load->model('ecslideshow/banner');

			$data = array();
			$selected = isset($this->request->post['selected'])?$this->request->post['selected']:array();

			if($selected) {
				$data['filter_id'] = $selected;
			}

			$banners = $this->model_ecslideshow_banner->getBanners( $data );
			$data = array();
			if($banners) {

				foreach($banners as $banner){
					$tmpdata = array();
					$banner_images = $this->model_ecslideshow_banner->getBannerImages($banner['ecbanner_id']);
					$tmpdata['name'] = $banner['name'];
					$tmpdata['status'] = $banner['status'];
					$tmpdata['main_width'] = $banner['main_width'];
					$tmpdata['main_height'] = $banner['main_height'];
					if($banner_images) {
						$i = 1;
						foreach($banner_images as $banner_image) {
							$prefix = "image__".$i."__";
							$tmpdata[$prefix."link"] = $banner_image['link'];
							$tmpdata[$prefix."image"] = $banner_image['image'];
							$tmpdata[$prefix."product_id"] = $banner_image['product_id'];
							$tmpdata[$prefix."ordering"] = $banner_image['ordering'];
							$tmpdata[$prefix."params"] = $banner_image['params'];
							if(isset($banner_image['banner_image_description']) && $banner_image['banner_image_description']){
								$j = 1;
								foreach($banner_image['banner_image_description'] as $language_id => $description) {
									$prefix2 = $prefix."language__".$j."__";
									$tmpdata[$prefix2."title"] = $description['title'];
									$tmpdata[$prefix2."description"] = $description['description'];
									$tmpdata[$prefix2."custom_code"] = $description['custom_code'];
									$j++;
								}
							}
							$i++;
						}
					}
					$data[] = $tmpdata;
				}
			}
			echo $this->model_ecslideshow_banner->array2csv($data);
			die();

		} else {
			$this->redirect($this->url->link('module/ecslideshow/banner', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
	}
	protected function download_send_headers($filename) {
	    // disable caching
	    $now = gmdate("D, d M Y H:i:s");
	    header("Expires: Tue, 03 Jul 2001 06:00:00 GMT");
	    header("Cache-Control: max-age=0, no-cache, must-revalidate, proxy-revalidate");
	    header("Last-Modified: {$now} GMT");

	    // force download  
	    header("Content-Type: application/force-download");
	    header("Content-Type: application/octet-stream");
	    header("Content-Type: application/download");

	    // disposition / encoding on response body
	    header("Content-Disposition: attachment;filename={$filename}");
	    header("Content-Transfer-Encoding: binary");
	}
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/ecslideshow')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['ecslideshow_module'])) {

		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'module/ecslideshow')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        $error = array();
        if ((strlen(utf8_decode($this->request->post['name'])) < 3) || (strlen(utf8_decode($this->request->post['name'])) > 100)) {
            $error[] = $this->language->get('error_name');
        }
        $error_title = $this->language->get('error_title');

        if (isset($this->request->post['banner_image'])) {
            foreach ($this->request->post['banner_image'] as $banner_image_id => $banner_image) {
                foreach ($banner_image['banner_image_description'] as $language_id => $banner_image_description) {
                    if ((strlen(utf8_decode($banner_image_description['title'])) < 2) || (strlen(utf8_decode($banner_image_description['title'])) > 100)) {
                        $this->error['banner_image'][$banner_image_id][$language_id] = $this->language->get('error_title');
                        $error[] = sprintf($error_title, $banner_image_id);
                    }

                }
            }
        }
        $html_error = "";
        if($error) {
        	$html_error = "<ul>";
        	foreach($error as $key=>$val) {
        		$html_error = "<li>".$val."</li>";
        	}
        	$html_error .= "</ul>";
        	$this->error['warning'] = $html_error;
        }
        
        $this->session->data['error'] = $this->error;

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'module/ecslideshow')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
    protected function defaultConfig($setting = array()){
        $defaults = array('skin'	=> 'camera_azure_skin',
            'alignment'				=> 'center',
            'support_rtl'			=> 1,
            'show_caption'			=> 1,
            'caption_effect'		=> 'moveFromBottom',
            'title_max_chars'		=> 100,
            'description_max_chars'	=> 150,
            'show_product_info'		=> 1,
            'auto_advance'			=> '1',
            'mobile_auto_advance'	=> '1',
            'bar_direction'			=> 'leftToRight',
            'bar_position'			=> 'bottom',
            'cols'					=> '6',
            'easing'				=> 'easeInOutExpo',
            'fx'					=> 'random',
            'grid_difference'		=> '250',
            'height'				=> '50%',
            'hover'					=> '1',
            'loader'				=> 'pie',
            'loader_color'			=> '#eeeeee',
            'loader_bg_color'		=> '#222222',
            'loader_opacity'		=> '.8',
            'min_height'			=> '200px',
            'navigation'			=> '1',
            'navigation_hover'		=> '1',
            'overlayer'				=> '1',
            'pagination'			=> '1',
            'play_pause'			=> '1',
            'pie_diameter'			=> '38',
            'pie_position'			=> 'rightTop',
            'rows'					=> '4',
            'sliced_cols'			=> '12',
            'sliced_rows'			=> '8',
            'slide_on'				=> 'random',
            'thumbnails'			=> '0',
            'time'					=> '7000',
            'trans_period'			=> '1500',
            'data_source'			=> 'banner',
            'limit'					=> '5',
            'module_width'			=> '800px',
            'module_height'			=> '600px',
            'main_width'			=> '800',
            'main_height'			=> '600',
            'thumbnail_width'		=> '100',
            'thumbnail_height'		=> '75',
            'banner_id'				=> '0'
        );
        if(!empty($setting)){
            return array_merge($defaults, $setting);
        }
        else{
            return $defaults;
        }
    }
}
?>

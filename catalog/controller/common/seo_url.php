<?php
class ControllerCommonSeoUrl extends Controller {

private $urlFriendly = array(
            'common/home'       => '',
            'checkout/cart'     => 'carrinho',
            'account/register'  => 'cadastre-se',
            'account/wishlist'  => 'lista-de-desejo',
            'checkout/checkout' => 'checkout',
            'account/logout'    => 'sair',
            'account/login'     => 'login',
            'product/special'   => 'especial',
            'affiliate/account' => 'afiliado',
            'checkout/voucher'  => 'vale-presente',
            'product/manufacturer' => 'fabricante',
            'account/newsletter'   => 'newsletter',
            'account/order'        => 'meus-pedidos',
            'account/account'      => 'minha-conta',
            'information/contact'  => 'contato',
            'information/sitemap'   => 'mapa-do-site',
            'account/forgotten'     => 'lembrar-senha',
            'account/download'     => 'meus-download',
            'account/return'     => 'minhas-devolucoes',
            'account/transaction'     => 'minhas-indicacoes',
            'account/password'     => 'alterar-senha',
            'account/edit'     => 'alterar-informacoes',
            'account/address'     => 'alterar-enderecos',
            'account/reward'     => 'pontos-de-fidelidade',
        );
		
	public function index() {
		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}
		
		// Decode URL
		if (isset($this->request->get['_route_'])) {
			$parts = explode('/', $this->request->get['_route_']);
			
			foreach ($parts as $part) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");
				
				if ($query->num_rows) {
					$url = explode('=', $query->row['query']);
					
					if ($url[0] == 'product_id') {
						$this->request->get['product_id'] = $url[1];
					}
					
					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					}	
					
					if ($url[0] == 'manufacturer_id') {
						$this->request->get['manufacturer_id'] = $url[1];
					}
					
					if ($url[0] == 'information_id') {
						$this->request->get['information_id'] = $url[1];
					}	
				} else {
					$this->request->get['route'] = 'error/not_found';	
				}
			}
			
			//Modificado
			if ($_key = $this->getKeyFriendly($this->request->get['_route_']) ) {
				$this->request->get['route'] = $_key;
			}elseif (isset($this->request->get['product_id'])) {
				$this->request->get['route'] = 'product/product';
			} elseif (isset($this->request->get['path'])) {
				$this->request->get['route'] = 'product/category';
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$this->request->get['route'] = 'product/manufacturer/product';
			} elseif (isset($this->request->get['information_id'])) {
				$this->request->get['route'] = 'information/information';
			}
			
			if (isset($this->request->get['route'])) {
				return $this->forward($this->request->get['route']);
			}
		}
	}
	
	public function rewrite($link) {
		if ($this->config->get('config_seo_url')) {
			$url_data = parse_url(str_replace('&amp;', '&', $link));
		
			$url = ''; 
			
			$data = array();
			
			parse_str($url_data['query'], $data);
			
			foreach ($data as $key => $value) {
				if (isset($data['route'])) {
					if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/product' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
					
						if ($query->num_rows) {
							$url .= '/' . $query->row['keyword'];
							
							unset($data[$key]);
						}					
					} elseif ($key == 'path') {
						$categories = explode('_', $value);
						
						foreach ($categories as $category) {
							$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");
					
							if ($query->num_rows) {
								$url .= '/' . $query->row['keyword'];
							}							
						}
						
						unset($data[$key]);
					}
					//Modificado
					if( $_link = $this->getValueFriendly($data['route']) ){
							 $url .= $_link;
							 unset($data[$key]);
						}
				}
			}
		
			if ($url) {
				unset($data['route']);
			
				$query = '';
			
				if ($data) {
					foreach ($data as $key => $value) {
						$query .= '&' . $key . '=' . $value;
					}
					
					if ($query) {
						$query = '?' . trim($query, '&');
					}
				}

				return $url_data['scheme'] . '://' . $url_data['host'] . (isset($url_data['port']) ? ':' . $url_data['port'] : '') . str_replace('/index.php', '', $url_data['path']) . $url . $query;
			} else {
				return $link;
			}
		} else {
			return $link;
		}		
	}
	//adicionado
	public function getKeyFriendly($_route) {
       if( count($this->urlFriendly) > 0 ){
			$key = array_search($_route, $this->urlFriendly);
			if($key && in_array($_route, $this->urlFriendly)){
				return $key;
			}
       }
       return false;
	}
	//adicionado
	public function getValueFriendly($route) {
      if( count($this->urlFriendly) > 0) {
		  if(in_array($route, array_keys($this->urlFriendly))){
				 return '/'.$this->urlFriendly[$route];
		  }
       }
      return false;
	}
	
}
?>
<?php 
	/******************************************************
	 * @package Pav Megamenu module for Opencart 1.5.x
	 * @version 1.1
	 * @author http://www.pavothemes.com
	 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
	 * @license		GNU General Public License version 2
	*******************************************************/

	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/development/libs/framework.php" );
	$themeConfig = $this->config->get('themecontrol');
	$themeName =  $this->config->get('config_template');
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$LANGUAGE_ID = $this->config->get( 'config_language_id' );  
?>
</div></div></section>
<?php
	/**
	 * Footer Top Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'mass_bottom' ); 
	$ospans = array( );
	$cols   = 1;
	if( count($modules) ) { 
?>
<section id="pav-mass-bottom">
	<div class="container">
		<?php $j=1;foreach ($modules as $i =>  $module) {   ?>
			<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
			<div class="col-lg-<?php echo floor(12/$cols);?> col-md-<?php echo floor(12/$cols);?> col-sm-12 col-xs-12"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
		<?php  $j++;  } ?>
	</div>	
</section>
<?php } ?>
<section id="footer">
	<?php
	/**
	 * Footer Top Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'footer_top' ); 
	$ospans = array();
	
	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_top'])&& $themeConfig['block_footer_top']?(int)$themeConfig['block_footer_top']:count($modules);
	//if( $cols < count($modules) ){ $cols = count($modules); }
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<div class="footer-top">
		<div class="container">
			<div class="container-inner">
			<?php $j=1;foreach ($modules as $i =>  $module) {   ?>
				<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
				<div class="<?php echo $class[$j];?>  col-md-6"><?php echo $module; ?></div>
				<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
			<?php  $j++;  } ?>
		</div>
		</div>
	</div>
	<?php } ?>
	<?php
	/**
	 * Footer Center Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'footer_center' ); 
	$ospans = array();
	
	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_center'])&& $themeConfig['block_footer_center']?(int)$themeConfig['block_footer_center']:count($modules);
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<div class="footer-center">
		<div class="container">
			<div class="container-inner">
				<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
					<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
					<div class="<?php echo $class[$j];?> column"><?php echo $module; ?></div>
					<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
				<?php  $j++;  } ?>	
			</div>
		</div>
	</div>
	<?php } elseif((isset($themeConfig['enable_footer_center'])&&$themeConfig['enable_footer_center'])) { ?>
	<div class="footer-center">
		<div class="container">
			<div class="container-inner">
			<div class="row">
		  		<?php if( isset($themeConfig['widget_contactus_data'][$LANGUAGE_ID]) ) { ?>
				<div class="column col-xs-12 col-sm-6 col-lg-3">
					<div class="box contact-us">
						<div class="box-heading"><span><?php echo $this->language->get('text_contact_us'); ?></span></div>
						<?php echo html_entity_decode( $themeConfig['widget_contactus_data'][$LANGUAGE_ID], ENT_QUOTES, 'UTF-8' ); ?>
					</div>
				</div>
				 <?php } ?>
				  
				<div class="column col-xs-12 col-sm-6 col-lg-2">
					<div class="box">
						<div class="box-heading"><span><?php echo $text_service; ?></span></div>
						<ul class="list">
						  <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
						  <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
						  <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
						   <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
						  <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
						</ul>
					</div>
				</div>
				  
				<div class="column col-xs-12 col-sm-6 col-lg-2">
					<div class="box">
					<div class="box-heading"><span><?php echo $text_extra; ?></span></div>
					<ul class="list">
					  <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
					  <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
					  <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
					  <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
					</ul>
				  </div>
				</div>
				  
				<div class="column col-xs-12 col-sm-6 col-lg-2">
					<div class="box">
						<div class="box-heading"><span><?php echo $text_account; ?></span></div>
						<ul class="list">
						  <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
						  <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
						  <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
						  <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
						  <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
						</ul>
					</div>
				</div>
				<div class="column col-xs-12 col-sm-6 col-lg-2">
					<div class="box">
						<div class="box-heading"><span>Redes Sociais</span></div>
						<div class="icones">
							<ul>
								<li><a id="fb" title="Robotrônica Facebook" target="_blank" href="https://www.facebook.com/robotronicaa"></a></li>
								<li><a id="tw" title="Robotrônica Twitter" target="_blank" href="https://twitter.com/robotronica2014"></a></li>
								<li><a id="yt" title="Robotrônica Youtube" target="_blank" href="https://www.youtube.com/user/robotronicaa/videos"></a></li>
							</ul>
							<script type="text/javascript" src="http://www.robotronica.com.br/catalog/view/javascript/skype-uri.js"></script>
							<div id="SkypeButton_Call_robotronica._1" class="skype">
							  <script type="text/javascript">
							    Skype.ui({
							      "name": "chat",
							      "element": "SkypeButton_Call_robotronica._1",
							      "participants": ["robotronica."],
							      "imageSize": 32
							    });
							  </script>
							</div>
						</div>
					</div>
				</div>
				<div class="column col-xs-12 col-sm-6 col-lg-2">
					<div class="box">
						<div class="fb-like-box" data-href="https://www.facebook.com/robotronicaa" data-colorscheme="light" data-show-faces="true" data-header="true" data-stream="false" data-show-border="true"></div>
					</div>
				</div>
				<?php if( isset($themeConfig['widget_newsletter_data'][$LANGUAGE_ID]) ) {

				 ?>
				<div class="column col-xs-12 col-sm-6 col-lg-3">
					<div class="box newsletter">
						<div class="box-heading"><span><?php echo $this->language->get('Newsletter'); ?></span></div>
						<?php echo html_entity_decode( $themeConfig['widget_newsletter_data'][$LANGUAGE_ID], ENT_QUOTES, 'UTF-8' ); ?>
					</div>
				</div>
				 <?php } ?>
				 </div> 
			 </div> 
		</div>
	</div>
	<?php  } ?>	
	<?php
	/**
	 * Footer Bottom
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'footer_bottom' ); 
	$ospans = array();
	
	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_bottom'])&& $themeConfig['block_footer_bottom']?(int)$themeConfig['block_footer_bottom']:count($modules);	
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<div class="footer-bottom">
		<div class="container">
		<div class="container-inner">
		<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
				<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
				<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
				<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
		<?php  $j++;  } ?>	
		</div>
		 </div> 
	</div>
	<?php } ?>

	<!--
	OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
	Please donate via PayPal to donate@opencart.com
	//-->
	<div id="powered">
		<div class="container">
			<div class="container-inner">
				<div class="copyright">
					<p>© 2014 <a href="/" title="Robotrônica">Robotrônica</a>. Todos os direitos reservados.</p>
				</div>
			</div>
		</div>
	</div>
</section>

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
<?php if( isset($themeConfig['enable_paneltool']) && $themeConfig['enable_paneltool'] ){  ?>
	<?php  echo $helper->renderAddon( 'panel' );?>
<?php } ?>
</section> 
</body></html>
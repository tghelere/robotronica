<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
 
 <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>  
<?php if( $SPAN[0] ): ?>
	<div class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	</div>
	
<?php endif; ?> 
<div class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
<div id="content" class="content-blog"><?php echo $content_top; ?>
  	<!--<div class="pav-header">
		<h1><?php echo $heading_title; ?></h1>
		<a class="rss-wrapper" href="<?php echo $latest_rss;?>"><span class="icon-rss">Rss</span></a>	
	</div>  -->
  
  <div class="pav-filter-blogs">

		<div class="pav-blogs">
			<?php
			$cols = $config->get('cat_columns_leading_blog');
			$span = floor(12/$cols);
			if( count($leading_blogs) ) { ?>
				<div class="leading-blogs clearfix">
					<?php foreach( $leading_blogs as $key => $blog ) { ?>
					<?php if( $key++%$cols == 0 ) { ?>
					  <div class="row">
				<?php } ?>
					<div class="col-lg-<?php echo $span;?>">
					<?php require( '_item.tpl' ); ?>
					</div>
					<?php if( ( $key%$cols==0 || $key == count($leading_blogs)) ){ ?>
					</div>
					<?php } ?>
					<?php } ?>
				</div>
			<?php } ?>

			<?php
				$cols = $config->get('cat_columns_secondary_blogs');
			$span = floor(12/$cols);
				if ( count($secondary_blogs) ) { ?>
				<div class="secondary clearfix">
					
					<?php foreach( $secondary_blogs as $key => $blog ) { ?>
					<?php if( $key++%$cols == 0 ) { ?>
					  <div class="row">
				<?php } ?>
					<div class="col-lg-<?php echo $span;?>">
					<?php require( '_item.tpl' ); ?>
					</div>
					<?php if( ( $key%$cols==0 || $key == count($secondary_blogs)) ){ ?>
						</div>
					<?php } ?>
					<?php } ?>
				</div>
			<?php } ?>
				
			<div class="pav-pagination pagination"><?php echo $pagination;?></div>
		</div>
  </div>
 

  <?php echo $content_bottom; ?></div>

</div> 
<?php if( $SPAN[2] ): ?>
<div class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
	<?php echo $column_right; ?>
</div>
<?php endif; ?>
<?php echo $footer; ?>
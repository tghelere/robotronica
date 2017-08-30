<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if (isset($success) && $success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="slidebar"><?php require( DIR_APPLICATION.'view/template/module/ecslideshow/toolbar.tpl' ); ?></div>
    <div class="heading">
      <h1><img src="view/image/banner.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_import; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <?php if(isset($message)) { 
        echo $message;
      } else { ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div style="text-align:center">
          <input type="hidden" name="action" id="action" value=""/>
          <br/>
          <input type="file" name="file" id="csvfile"/>
          <br/>
          <?php echo $text_help_import;?>
      </div>
      </form>
      <?php } ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>
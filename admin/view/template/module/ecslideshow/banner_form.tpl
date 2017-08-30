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
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#action').val('save_stay');$('#form').submit();" class="button"><?php echo $this->language->get("button_save_stay"); ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <input type="hidden" name="action" id="action" value=""/>
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_name; ?></td>
            <td><input type="text" name="name" value="<?php echo $name; ?>" size="100" />
              <?php if ($error_name) { ?>
              <span class="error"><?php echo $error_name; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="status">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
              <td><?php echo $this->language->get("entry_main_width"); ?></td>
              <td><input type="text" name="main_width" value="<?php echo isset($main_width)?$main_width:""; ?>" size="10" /></td>
            </tr>
            <tr>
              <td><?php echo $this->language->get("entry_main_height"); ?></td>
              <td><input type="text" name="main_height" value="<?php echo isset($main_height)?$main_height:""; ?>" size="10" /></td>
            </tr>
        </table>
        <p><strong><?php echo $this->language->get("text_banner_image");?></strong></p>
        <div class="vtabs">
          <?php $image_row = 1; ?>
          <?php foreach ($banner_images as $banner_image) { ?>
         
          <a href="#tab-module-<?php echo $image_row; ?>" id="module-<?php echo $image_row; ?>"><?php echo $this->language->get("tab_banner") . ' ' . $image_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $image_row; ?>').remove(); $('#tab-module-<?php echo $image_row; ?>').remove(); return false;" /></a>
          <?php $image_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_banner; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addImage();" /></span> 
        </div>
          <?php $image_row = 1; ?>
          <?php foreach ($banner_images as $banner_image) { ?>
          <div id="tab-module-<?php echo $image_row; ?>" class="vtabs-content">
             <div id="language-<?php echo $image_row; ?>" class="htabs">
                <?php foreach ($languages as $language) { ?>
                <a href="#tab-language-<?php echo $image_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
                <?php } ?>
              </div>
              <?php foreach ($languages as $language) { ?>
                <div id="tab-language-<?php echo $image_row; ?>-<?php echo $language['language_id']; ?>">
                  <table class="form">
                    <tr>
                      <td><span class="required">*</span> <?php echo $this->language->get( 'entry_title' ); ?></td>
                      <td><input size="60" name="banner_image[<?php echo $image_row; ?>][banner_image_description][<?php echo $language['language_id']; ?>][title]" id="title-<?php echo $image_row; ?>-<?php echo $language['language_id']; ?>" value="<?php echo isset($banner_image['banner_image_description'][$language['language_id']]['title']) ? $banner_image['banner_image_description'][$language['language_id']]['title'] : ''; ?>"/></td>
                    </tr>
                    
                    <tr>
                      <td><?php echo $this->language->get('entry_description'); ?></td>
                      <td><textarea name="banner_image[<?php echo $image_row; ?>][banner_image_description][<?php echo $language['language_id']; ?>][description]" id="description-<?php echo $image_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($banner_image['banner_image_description'][$language['language_id']]['description']) ? $banner_image['banner_image_description'][$language['language_id']]['description'] : ''; ?></textarea></td>
                    </tr>
                    <tr>
                      <td><?php echo $this->language->get('entry_custom_code'); ?></td>
                      <td><textarea  cols="25" rows="10" style="width:500px;" name="banner_image[<?php echo $image_row; ?>][banner_image_description][<?php echo $language['language_id']; ?>][custom_code]" id="custom_code-<?php echo $image_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($banner_image['banner_image_description'][$language['language_id']]['custom_code']) ? $banner_image['banner_image_description'][$language['language_id']]['custom_code'] : ''; ?></textarea></td>
                    </tr>
                  </table>
                </div>
                <?php } ?>
                 <?php
                  $params = isset($banner_image['params'])?$banner_image['params']:array();
                ?>
                <table id="images" class="form">
                  <tr>
                    <td><?php echo $this->language->get("entry_video_embed_code");?></td>
                    <td><textarea  cols="25" rows="10" style="width:500px;" name="banner_image[<?php echo $image_row; ?>][params][video_code]"><?php echo isset($params['video_code'])?$params['video_code']:""; ?></textarea></td>
                   </tr>
                   <tr>
                      <td><?php echo $this->language->get( 'entry_product' ); ?></td>
                      <td>
                        <input type="text" id="product_autocomplete_<?php echo $image_row; ?>" name="products" value="" size="40" placeholder="<?php echo $this->language->get("text_input_product_name");?>"/><?php echo $this->language->get( 'entry_product_id' ); ?>
                        <input size="10" type="text" id="banner_image_<?php echo $image_row; ?>_product" name="banner_image[<?php echo $image_row; ?>][product_id]" value="<?php echo $banner_image['product_id']; ?>" />
                      <script type="text/javascript">
                        jQuery(function(){
                          initAutocomplete(<?php echo $image_row; ?>);
                        })
                      </script>
                      </td>
                    <tr>
                      <td><?php echo $entry_link; ?></td>
                      <td class="left"><input size="60" type="text" name="banner_image[<?php echo $image_row; ?>][link]" value="<?php echo $banner_image['link']; ?>" /></td>
                    </tr>
                     <tr>
                      <td><?php echo $this->language->get( 'entry_sort_order' ); ?></td>
                      <td class="left"><input size="40" type="text" name="banner_image[<?php echo $image_row; ?>][ordering]" value="<?php echo $banner_image['ordering']; ?>" /></td>
                    </tr>
                    <tr>
                      <td><?php echo $entry_image; ?></td>
                      <td class="left"><div class="image"><img src="<?php echo $banner_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>" />
                          <input type="hidden" name="banner_image[<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="image<?php echo $image_row; ?>"  />
                          <br />
                          <a onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
                    </tr>
                   <tr class="heading">
                    <td colspan="2"><?php echo $this->language->get("entry_slideshow_effect"); ?></td>
                   </tr>
                    <tr>
                    <td><?php echo $this->language->get("entry_caption_class");?></td>
                    <td><input type="text" name="banner_image[<?php echo $image_row; ?>][params][caption_class]" value="<?php echo isset($params['caption_class'])?$params['caption_class']:""; ?>" size="30"/></td>
                   </tr>
                   <tr>
                    <td><?php echo $this->language->get("entry_caption_alignment");?></td>
                    <td><select name="banner_image[<?php echo $image_row; ?>][params][caption_alignment]">
                      <option value="3"><?php echo $this->language->get("text_default");?></option>
                      <?php
                        foreach($caption_alignment as $alignment){
                          $alignment = trim($alignment);
                          if(isset($params['caption_alignment']) && ($alignment == $params['caption_alignment'])){
                            ?>
                            <option value="<?php echo $alignment;?>" selected="selected"><?php echo $alignment; ?></option>
                            <?php
                          }else{
                             ?>
                            <option value="<?php echo $alignment;?>"><?php echo $alignment; ?></option>
                            <?php
                          }
                        }
                      ?>
                    </select></td>
                   </tr>

                   <tr>
                    <td><?php echo $this->language->get("entry_image_alignment");?></td>
                    <td><select name="banner_image[<?php echo $image_row; ?>][params][image_alignment]">
                      <option value="3"><?php echo $this->language->get("text_default");?></option>
                      <?php
                        foreach($image_alignments as $alignment){
                          $alignment = trim($alignment);
                          if(isset($params['image_alignment']) && ($alignment == $params['image_alignment'])){
                            ?>
                            <option value="<?php echo $alignment;?>" selected="selected"><?php echo $alignment; ?></option>
                            <?php
                          }else{
                             ?>
                            <option value="<?php echo $alignment;?>"><?php echo $alignment; ?></option>
                            <?php
                          }
                        }
                      ?>
                    </select></td>
                   </tr>
                   <tr>
                    <td><?php echo $this->language->get("entry_easing");?></td>
                    <td><select name="banner_image[<?php echo $image_row; ?>][params][easing]">
                      <option value="3"><?php echo $this->language->get("text_default");?></option>
                      <?php
                        foreach($easings as $item_value){
                          $item_value = trim($item_value);
                          if(isset($params['easing']) && ($item_value == $params['easing'])){
                            ?>
                            <option value="<?php echo $item_value;?>" selected="selected"><?php echo $item_value; ?></option>
                            <?php
                          }else{
                             ?>
                            <option value="<?php echo $item_value;?>"><?php echo $item_value; ?></option>
                            <?php
                          }
                        }
                      ?>
                    </select></td>
                   </tr>
                    <tr>
                    <td><?php echo $this->language->get("entry_effect");?></td>
                    <td><select name="banner_image[<?php echo $image_row; ?>][params][effect]">
                      <option value="3"><?php echo $this->language->get("text_default");?></option>
                      <?php
                        foreach($effects as $item_value){
                          $item_value = trim($item_value);
                          if(isset($params['effect']) && ($item_value == $params['effect'])){
                            ?>
                            <option value="<?php echo $item_value;?>" selected="selected"><?php echo $item_value; ?></option>
                            <?php
                          }else{
                             ?>
                            <option value="<?php echo $item_value;?>"><?php echo $item_value; ?></option>
                            <?php
                          }
                        }
                      ?>
                    </select></td>
                   </tr>
                   <tr>
                    <td><?php echo $this->language->get("entry_show_caption");?></td>
                    <td><select name="banner_image[<?php echo $image_row; ?>][params][show_caption]">
                      <option value="3"><?php echo $this->language->get("text_default");?></option>
                      <?php
                        foreach($yesno as $key=>$val){
                          if(isset($params['show_caption']) && ($key == $params['show_caption'])){
                            ?>
                            <option value="<?php echo $key;?>" selected="selected"><?php echo $val; ?></option>
                            <?php
                          }else{
                             ?>
                            <option value="<?php echo $key;?>"><?php echo $val; ?></option>
                            <?php
                          }
                        }
                      ?>
                    </select></td>
                   </tr>
                   <tr>
                    <td><?php echo $this->language->get("entry_show_slider_link");?></td>
                    <td><select name="banner_image[<?php echo $image_row; ?>][params][show_link]">
                      <?php
                        foreach($yesno as $key=>$val){
                          if(isset($params['show_link']) && ($key == $params['show_link'])){
                            ?>
                            <option value="<?php echo $key;?>" selected="selected"><?php echo $val; ?></option>
                            <?php
                          }else{
                             ?>
                            <option value="<?php echo $key;?>"><?php echo $val; ?></option>
                            <?php
                          }
                        }
                      ?>
                    </select></td>
                   </tr>
                   
                </table>
            </div>
          <?php $image_row++; ?>
          <?php } ?>
         
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php $image_row = 1; ?>
<?php foreach ($banner_images as $banner_image) { ?>
  <?php foreach ($languages as $language) { ?>
  CKEDITOR.replace('description-<?php echo $image_row; ?>-<?php echo $language['language_id']; ?>', {
    filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
  });
  <?php } ?>
  <?php $image_row++; ?>
<?php } ?>
//--></script>
<script type="text/javascript"><!-- 
function initAutocomplete(module_index){
   
    $('#product_autocomplete_'+module_index).autocomplete({
            delay: 0,
            source: function(request, response) {
              $.ajax({
                url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
                dataType: 'json',
                data: {token: '<?php echo $token; ?>', filter_name: encodeURIComponent(request.term)},
                type: 'POST',
                success: function(json) {   
                  response($.map(json, function(item) {
                    return {
                      label: item.name,
                      value: item.product_id
                    }
                  }));
                }
              });
            }, 
            select: function(event, ui) {
              $('#banner_image_'+module_index+'_product').val(ui.item.value);
              return false;
            }
          });
  }
//--></script>
<script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;
$('.vtabs a').tabs();
function addImage() {
  var html = '<div id="tab-module-'+image_row+'" class="vtabs-content">';
    html +='           <div id="language-'+image_row+'" class="htabs">';
                <?php foreach ($languages as $language) { ?>
    html +='              <a href="#tab-language-'+image_row+'-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
                <?php } ?>
    html +='            </div>';
              <?php foreach ($languages as $language) { ?>
    html +='             <div id="tab-language-'+image_row+'-<?php echo $language['language_id']; ?>">';
    html +='              <table class="form">';
    html +=' <tr>';
    html +='                  <td><span class="required">*</span> <?php echo $this->language->get( 'entry_title' ); ?></td>';
    html +='                  <td><input size="60" name="banner_image['+image_row+'][banner_image_description][<?php echo $language['language_id']; ?>][title]" id="title-'+image_row+'-<?php echo $language['language_id']; ?>" value=""/></td>';
    html +='                </tr>';
                    
    html +='                <tr>';
    html +='                  <td><?php echo $this->language->get('entry_description'); ?></td>';
    html +='                  <td><textarea name="banner_image['+image_row+'][banner_image_description][<?php echo $language['language_id']; ?>][description]" id="description-'+image_row+'-<?php echo $language['language_id']; ?>"></textarea></td>';
    html +='                </tr>';
    html +='<tr>';
    html +='                  <td><?php echo $this->language->get('entry_custom_code'); ?></td>';
    html +='                  <td><textarea  cols="25" rows="10" style="width:500px;heigt:200px" name="banner_image['+image_row+'][banner_image_description][<?php echo $language['language_id']; ?>][custom_code]" id="custom_code-<?php echo $image_row; ?>-<?php echo $language['language_id']; ?>"></textarea></td>';
    html +='                </tr>';
    html +='              </table>';
    html +='            </div>';
                <?php } ?>
    html +='            <table id="images" class="form">';
    html +='<tr>';
    html +='                <td><?php echo $this->language->get("entry_video_embed_code");?></td>';
    html +='                <td><textarea  cols="25" rows="10" style="width:500px;" name="banner_image['+image_row+'][params][video_code]"></textarea></td>';
    html +='               </tr>';
    html +='<tr>';
    html +='                  <td><?php echo $this->language->get( 'entry_product' ); ?></td>';
    html +='                  <td class="left"><input type="text" id="product_autocomplete_'+image_row+'" name="products" value="" size="40" placeholder="<?php echo $this->language->get("text_input_product_name");?>"/> <?php echo $this->language->get('entry_product_id');?>
                        <input size="10" type="text" id="banner_image_'+image_row+'_product" name="banner_image['+image_row+'][product_id]" value="" /></td>';
    html +='                </tr>';
    html +='                <tr>';
    html +='                  <td><?php echo $entry_link; ?></td>';
    html +='                  <td class="left"><input size="60" type="text" name="banner_image['+image_row+'][link]" value="" /></td>';
   
    html +='                </tr>';
    html +=' <tr>';
    html +='                  <td><?php echo $this->language->get( 'entry_sort_order' ); ?></td>';
    html +='                  <td class="left"><input size="40" type="text" name="banner_image['+image_row+'][ordering]" value="" /></td>';
    html +='                </tr>';
    html +='                <tr>';
    html +='                  <td><?php echo $entry_image; ?></td>';
    html +='                  <td class="left"><div class="image"><img src="" alt="" id="thumb'+image_row+'" />';
    html +='                      <input type="hidden" name="banner_image['+image_row+'][image]" value="" id="image'+image_row+'"  />';
    html +='                      <br />';
    html +='                      <a onclick="image_upload(\'image'+image_row+'\', \'thumb'+image_row+'\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb'+image_row+'\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image'+image_row+'\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
    html +='                </tr>';
    html +='<tr class="heading">';
    html +='                <td colspan="2"><?php echo $this->language->get("entry_slideshow_effect"); ?></td>';
    html +='               </tr>';
    html +=' <tr>';
    html +='                <td><?php echo $this->language->get("entry_caption_class");?></td>';
    html +='                <td><input type="text" name="banner_image['+image_row+'][params][caption_class]" value="" size="30"/></td>';
    html +='               </tr>';
    html +='               <tr>';
    html +='                <td><?php echo $this->language->get("entry_caption_alignment");?></td>';
    html +='                <td><select name="banner_image['+image_row+'][params][caption_alignment]">';
    html +='                  <option value="3"><?php echo $this->language->get("text_default");?></option>';
                    <?php
                        foreach($caption_alignment as $alignment){
                          $alignment = trim($alignment);
                            ?>
    html +='                        <option value="<?php echo $alignment;?>"><?php echo $alignment; ?></option>';
                            <?php
                        }
                      ?>
    html +='                </select></td>';
    html +='               </tr>';
    html +='               <tr>';
    html +='                <td><?php echo $this->language->get("entry_image_alignment");?></td>';
    html +='                <td><select name="banner_image['+image_row+'][params][image_alignment]">';
    html +='                  <option value="3"><?php echo $this->language->get("text_default");?></option>';
                      <?php
                        foreach($image_alignments as $alignment){
                          $alignment = trim($alignment);
                         
                            ?>
    html +='                        <option value="<?php echo $alignment;?>"><?php echo $alignment; ?></option>';
                            <?php
                          
                        }
                      ?>
    html +='                </select></td>';
    html +='               </tr>';
    html +='               <tr>';
    html +='                <td><?php echo $this->language->get("entry_easing");?></td>';
    html +='                <td><select name="banner_image['+image_row+'][params][easing]">';
    html +='                  <option value="3"><?php echo $this->language->get("text_default");?></option>';
                      <?php
                        foreach($easings as $item_value){
                          $item_value = trim($item_value);
                            ?>
    html +='                        <option value="<?php echo $item_value;?>"><?php echo $item_value; ?></option>';
                            <?php
                        }
                      ?>
    html +='                </select></td>';
    html +='               </tr>';
    html +='                <tr>';
    html +='                <td><?php echo $this->language->get("entry_effect");?></td>';
    html +='                <td><select name="banner_image['+image_row+'][params][effect]">';
    html +='                  <option value="3"><?php echo $this->language->get("text_default");?></option>';
                      <?php
                        foreach($effects as $item_value){
                          $item_value = trim($item_value);
                             ?>
    html +='                        <option value="<?php echo $item_value;?>"><?php echo $item_value; ?></option>';
                            <?php
                        }
                      ?>
    html +='                </select></td>';
    html +='               </tr>';
    html +='<tr>';
    html +='                <td><?php echo $this->language->get("entry_show_caption");?></td>';
    html +='                <td><select name="banner_image['+image_row+'][params][show_caption]">';
    html +=' <option value="3"><?php echo $this->language->get("text_default");?></option>';
                      <?php
                        foreach($yesno as $key=>$val){
                            ?>
    html +='                        <option value="<?php echo $key;?>"><?php echo $val; ?></option>';
                            <?php
                        }
                      ?>
    html +='                </select></td>';
    html +='               </tr>';
    html +='<tr>';
    html +='                <td><?php echo $this->language->get("entry_show_slider_link");?></td>';
    html +='                <td><select name="banner_image['+image_row+'][params][show_link]">';
                      <?php
                        foreach($yesno as $key=>$val){
                            ?>
    html +='                        <option value="<?php echo $key;?>"><?php echo $val; ?></option>';
                            <?php
                        }
                      ?>
    html +='                </select></td>';
    html +='               </tr>';
    html +='            </table>';
    html +='        </div>';
  
  $('#form').append(html);

  $('#language-'+image_row+' a').tabs();
  
  $('#module-add').before('<a href="#tab-module-'+image_row+'" id="module-'+image_row+'"><?php echo $this->language->get('tab_banner'); ?> '+image_row+'&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-'+image_row+'\').remove(); $(\'#tab-module-'+image_row+'\').remove(); return false;" /></a>');
  
  $('.vtabs a').tabs();
   <?php foreach ($languages as $language) { ?>
  CKEDITOR.replace('description-'+image_row+'-<?php echo $language['language_id']; ?>', {
    filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
    filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
  });
  <?php } ?>
  initAutocomplete(image_row);
  $('#module-'+image_row).trigger('click');

  image_row++;
}
//--></script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
  $('#dialog').remove();
  
  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
  
  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
    close: function (event, ui) {
      if ($('#' + field).attr('value')) {
        $.ajax({
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
          dataType: 'text',
          success: function(data) {
            $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
          }
        });
      }
    },  
    bgiframe: false,
    width: 700,
    height: 400,
    resizable: false,
    modal: false
  });
};
//--></script>
<script type="text/javascript"><!--
<?php $image_row = 1; ?>
<?php foreach ($banner_images as $banner_image) { ?>
$('#language-<?php echo $image_row; ?> a').tabs();
<?php $image_row++; ?>
<?php } ?> 
//--></script>
<?php echo $footer; ?>
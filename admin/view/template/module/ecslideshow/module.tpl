<?php echo $header;?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="slidebar"><?php require( DIR_APPLICATION.'view/template/module/ecslideshow/toolbar.tpl' ); ?></div>
    <div id="sticky_navigation" class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="$('#action').val('save_stay');$('#form').submit();" class="button"><?php echo $button_save_stay; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <input type="hidden" name="action" id="action" value=""/>
         
                  <div class="vtabs">
                    <?php $module_row = 1; ?>
                    <?php foreach ($modules as $module) { ?>
                    <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_block . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
                    <?php $module_row++; ?>
                    <?php } ?>
                    <span id="module-add"><?php echo $button_add_new_block; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> 
                  </div>
                  <?php $module_row = 1; ?>
                  <?php foreach ($modules as $module) { ?>
                  <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">  
                    <table class="form">
                      <tr>
                        <td><?php echo $entry_layout; ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][layout_id]">
                            <?php if ($module['layout_id'] == 0) { ?>
                            <option value="0" selected="selected"><?php echo $text_alllayout; ?></option>
                            <?php } else { ?>
                            <option value="0"><?php echo $text_alllayout; ?></option>
                            <?php } ?>
                            <?php foreach ($layouts as $layout) { ?>
                            <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                            <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                            <?php } ?>
                            <?php } ?>
                          </select></td>
                      </tr>
                <tr>
                  <td><?php echo $entry_store; ?></td>
                        <td><div class="scrollbox">
                            <?php $class = 'even'; ?>
                            <div class="<?php echo $class; ?>">
                              <?php if (isset($module['store_id']) && in_array(0, $module['store_id'])) { ?>
                              <input type="checkbox" name="ecslideshow_module[<?php echo $module_row; ?>][store_id][]" value="0" checked="checked" />
                              <?php } else { ?>
                              <input type="checkbox" name="ecslideshow_module[<?php echo $module_row; ?>][store_id][]" value="0" />
                              <?php } ?>
                    <?php echo $text_default; ?>
                            </div>
                            <?php foreach ($stores as $store) { ?>
                            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                            <div class="<?php echo $class; ?>">
                              <?php if (isset($module['store_id']) && in_array($store['store_id'], $module['store_id'])) { ?>
                              <input type="checkbox" name="ecslideshow_module[<?php echo $module_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                              <?php echo $store['name']; ?>
                              <?php } else { ?>
                              <input type="checkbox" name="ecslideshow_module[<?php echo $module_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" />
                              <?php echo $store['name']; ?>
                              <?php } ?>
                            </div>
                            <?php } ?>
                          </div></td>
                      </tr>
                      <tr>
                        <td><?php echo $entry_position; ?></td>
                        <td>
                          <?php 
                          $custom_position = (isset($module['custom_position']) && !empty($module['custom_position']))?$module['custom_position']:'';
                          $tmp_positions = $positions;
                          if(!empty($custom_position)){
                            $tmp_positions[] = $custom_position;
                          }
                          
                          ?>
                          <select name="ecslideshow_module[<?php echo $module_row; ?>][position]">
                                     <?php foreach( $tmp_positions as $pos ) { ?>
                                              <?php if ($module['position'] == $pos) { ?>
                                              <option value="<?php echo $pos;?>" selected="selected"><?php echo $this->language->get('text_'.$pos); ?></option>
                                              <?php } else { ?>
                                              <option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>
                                              <?php } ?>
                                              <?php } ?> 
                                            </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $entry_custom_position; ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][custom_position]" value="<?php echo $custom_position; ?>" size="30" /></td>
                      </tr>
                      <tr>
                        <td><?php echo $entry_status; ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][status]">
                            <?php if ($module['status']) { ?>
                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                            <option value="0"><?php echo $text_disabled; ?></option>
                            <?php } else { ?>
                            <option value="1"><?php echo $text_enabled; ?></option>
                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                            <?php } ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $entry_sort_order; ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_support_rtl"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][support_rtl]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['support_rtl']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_async_loading"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][enable_async]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['enable_async']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_banner"); ?></td>
                        <td><select size="10" name="ecslideshow_module[<?php echo $module_row; ?>][banner_id]">
                          <option value="0"><?php echo $this->language->get("text_select_banner");?></option>
                            <?php 
                             if($banners){
                              foreach($banners as $banner){
                                if($banner['ecbanner_id'] == $module['banner_id']){
                                ?>
                                  <option value="<?php echo $banner['ecbanner_id'] ?>" selected="selected"><?php echo $banner['name']; ?></option>
                                <?php
                                }else{
                                  ?>
                                   <option value="<?php echo $banner['ecbanner_id'] ?>"><?php echo $banner['name']; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>

                      <tr>
                        <td><?php echo $this->language->get("entry_limit"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="10" /></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_random_slider"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][random_mode]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['random_mode']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>

                       <tr>
                        <td><?php echo $this->language->get("entry_module_width"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][module_width]" value="<?php echo $module['module_width']; ?>" size="10" /></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_module_height"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][module_height]" value="<?php echo $module['module_height']; ?>" size="10" /></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_main_width"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][main_width]" value="<?php echo $module['main_width']; ?>" size="10" /></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_main_height"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][main_height]" value="<?php echo $module['main_height']; ?>" size="10" /></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_thumbnail_width"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][thumbnail_width]" value="<?php echo $module['thumbnail_width']; ?>" size="10" /></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_thumbnail_height"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][thumbnail_height]" value="<?php echo $module['thumbnail_height']; ?>" size="10" /></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_resize_type"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][resize_type]">
                            <?php 
                             if($resiztypes){
                              foreach($resiztypes as $key=>$val){
                                if($key == $module['resize_type']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td colspan="2"><b><?php echo $this->language->get("entry_slider_caption"); ?></b></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_show_caption"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][show_caption]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['show_caption']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_strip_html_code"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][is_striped]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['is_striped']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_show_custom_code"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][show_custom_code]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['show_custom_code']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_caption_effect"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][caption_effect]">
                            <?php 
                             if($caption_effects){
                              foreach($caption_effects as $val){
                                if($val == $module['caption_effect']){
                                ?>
                                  <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $val; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_show_product_info"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][show_product_info]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['show_product_info']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_title_max_chars"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][title_max_chars]" value="<?php echo $module['title_max_chars']; ?>" size="10" /></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_description_max_chars"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][description_max_chars]" value="<?php echo $module['description_max_chars']; ?>" size="10" /></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_caption_background_color"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][background_color]" value="<?php echo isset($module['background_color'])?$module['background_color']:""; ?>" class="picker" id="background_color_<?php echo $module_row;?>" style="border-color:<?php echo isset($module['background_color'])?"#".$module['background_color']:""; ?>"/></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_caption_text_color"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][text_color]" value="<?php echo isset($module['text_color'])?$module['text_color']:""; ?>" class="picker" id="text_color_<?php echo $module_row;?>" style="border-color:<?php echo isset($module['text_color'])?"#".$module['text_color']:""; ?>"/></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_caption_link_color"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][link_color]" value="<?php echo isset($module['link_color'])?$module['link_color']:""; ?>" class="picker" id="link_color_<?php echo $module_row;?>" style="border-color:<?php echo isset($module['link_color'])?"#".$module['link_color']:""; ?>"/></td>
                      </tr>
                      <tr>
                        <td colspan="2"><b><?php echo $this->language->get("entry_slider_effect"); ?></b></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_skin"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][skin]">
                            <?php 
                             if($skins){
                              foreach($skins as $skin){
                                $skin_name = str_replace("_", " ", $skin);
                                if($skin == $module['skin']){
                                ?>
                                  <option value="<?php echo $skin; ?>" selected="selected"><?php echo $skin_name; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $skin; ?>"><?php echo $skin_name; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_alignment"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][alignment]">
                            <?php 
                             if($alignments){
                              foreach($alignments as $key){
                                if($key == $module['alignment']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $key; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $key; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_auto_advance"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][auto_advance]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['auto_advance']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_mobile_auto_advance"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][mobile_auto_advance]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['mobile_auto_advance']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_bar_direction"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][bar_direction]">
                            <?php 
                             if($directions){
                              foreach($directions as $val){
                                if($val == $module['bar_direction']){
                                ?>
                                  <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $val; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_bar_position"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][bar_position]">
                            <?php 
                             if($bar_positions){
                              foreach($bar_positions as $val){
                                if($val == $module['bar_position']){
                                ?>
                                  <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $val; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_slide_height"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" size="10" /></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_min_height"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][min_height]" value="<?php echo $module['min_height']; ?>" size="10" /></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_cols"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][cols]" value="<?php echo $module['cols']; ?>" size="10" /></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_rows"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][rows]" value="<?php echo $module['rows']; ?>" size="10" /></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_easing"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][easing]">
                            <?php 
                             if($easings){
                              foreach($easings as $val){
                                if($val == $module['easing']){
                                ?>
                                  <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $val; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_fx"); ?></td>
                        <td><select multiple="multiple" name="ecslideshow_module[<?php echo $module_row; ?>][fx][]" size="10">
                            <?php 
                             if($effects){
                              foreach($effects as $val){
                                if(in_array($val,$module['fx'])){
                                ?>
                                  <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $val; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_hover"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][hover]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['hover']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_loader"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][loader]">
                            <?php 
                             if($loaders){
                              foreach($loaders as $val){
                                if($val == $module['loader']){
                                ?>
                                  <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $val; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_navigation"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][navigation]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['navigation']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_navigation_hover"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][navigation_hover]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['navigation_hover']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_pagination"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][pagination]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['pagination']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_play_pause"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][play_pause]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['play_pause']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                      <tr>
                        <td><?php echo $this->language->get("entry_thumbnails"); ?></td>
                        <td><select name="ecslideshow_module[<?php echo $module_row; ?>][thumbnails]">
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $module['thumbnails']){
                                ?>
                                  <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>
                                <?php
                                }else{
                                  ?>
                                  <option value="<?php echo $key; ?>"><?php echo $val; ?></option>
                                  <?php
                                }
                              }
                             }
                            ?>
                          </select></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_time"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][time]" value="<?php echo $module['time']; ?>" size="10" /></td>
                      </tr>
                       <tr>
                        <td><?php echo $this->language->get("entry_trans_period"); ?></td>
                        <td><input type="text" name="ecslideshow_module[<?php echo $module_row; ?>][trans_period]" value="<?php echo $module['trans_period']; ?>" size="10" /></td>
                      </tr>
                    </table>
                  </div>
                  <?php $module_row++; ?>
                  <?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$(function() {

    // grab the initial top offset of the navigation 
    var sticky_navigation_offset_top = $('#sticky_navigation').offset().top;
    
    // our function that decides weather the navigation bar should have "fixed" css position or not.
    var sticky_navigation = function(){
        var scroll_top = $(window).scrollTop(); // our current vertical position from the top
        
        // if we've scrolled more than the navigation, change its position to fixed to stick to top,
        // otherwise change it back to relative
        if (scroll_top > sticky_navigation_offset_top) {
            $('#sticky_navigation').css({ 'position': 'fixed', 'top':0, 'left':0, 'width': '100%' });
        } else {
            $('#sticky_navigation').css({ 'position': 'relative', 'width': '98.8%' }); 
        }   
    };
    
    // run our function on load
    sticky_navigation();
    
    // and run it again every time you scroll
    $(window).scroll(function() {
         sticky_navigation();
    });

});
//--></script>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;
function addModule() {
  html ='<div id="tab-module-'+module_row+'" class="vtabs-content"> ';
  html +='         <table class="form">';
  html +='          <tr>';
  html +='            <td><?php echo $entry_layout; ?></td>';
  html +='            <td><select name="ecslideshow_module['+module_row+'][layout_id]">';
  html +='                <option value="0"><?php echo $text_alllayout; ?></option>';
                  <?php foreach ($layouts as $layout) { ?>
  html +='                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
                  <?php } ?>
  html +='              </select></td>';
  html +='          </tr>';
  html +='    <tr>';
  html +='      <td><?php echo $entry_store; ?></td>';
  html +='            <td><div class="scrollbox">';
                  <?php $class = 'even'; ?>
  html +='                <div class="<?php echo $class; ?>">';
  html +='                  <input type="checkbox" name="ecslideshow_module['+module_row+'][store_id][]" value="0" checked="checked"/>';
  html +='        <?php echo $text_default; ?>';
  html +='                </div>';
                  <?php foreach ($stores as $store) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
  html +='                <div class="<?php echo $class; ?>">';
  html +='                  <input type="checkbox" name="ecslideshow_module['+module_row+'][store_id][]" value="<?php echo $store['store_id']; ?>" />';
  html +='                  <?php echo $store['name']; ?>';
  html +='                </div>';
                  <?php } ?>
  html +='              </div></td>';
  html +='    </tr>';

                     
  html +='          <tr>';
  html +='            <td><?php echo $entry_position; ?></td>';
  html +='            <td><select name="ecslideshow_module['+module_row+'][position]">';
                           <?php foreach( $positions as $pos ) { ?>
  html +='                                  <option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';
                                    <?php } ?> 
  html +='                                </select></td>';
  html +='          </tr>';
  html +=' <tr>';
  html +='                      <td><?php echo $entry_custom_position; ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][custom_position]" value="" size="30" /></td>';
  html +='                    </tr>';
  html +='          <tr>';
  html +='            <td><?php echo $entry_status; ?></td>';
  html +='            <td><select name="ecslideshow_module['+module_row+'][status]">';
  html +='                <option value="1"><?php echo $text_enabled; ?></option>';
  html +='                <option value="0"><?php echo $text_disabled; ?></option>';

  html +='              </select></td>';
  html +='          </tr>';
  html +='          <tr>';
  html +='            <td><?php echo $entry_sort_order; ?></td>';
  html +='            <td><input type="text" name="ecslideshow_module['+module_row+'][sort_order]" value="" size="3" /></td>';
  html +='          </tr>';
  html +='<tr>';
  html +='                      <td><?php echo $this->language->get("entry_support_rtl"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][support_rtl]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['support_rtl']){
                                ?>
  html +='                                <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                <?php
                                }else{
                                  ?>
  html +='                                <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';
                                  <?php
                                }
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='<tr>';
  html +='                      <td><?php echo $this->language->get("entry_banner"); ?></td>';
  html +='                      <td><select size="10" name="ecslideshow_module['+module_row+'][banner_id]">';
  html +='                        <option value="0"><?php echo $this->language->get("text_select_banner");?></option>';
                            <?php 
                             if($banners){
                              foreach($banners as $banner){
                                if($banner['ecbanner_id'] == $default['banner_id']){
                                  ?>
 html +='                       <option value="<?php echo $banner['ecbanner_id'] ?>" selected="selected"><?php echo $banner['name']; ?></option>';
                                  <?php
                                }else{
                                ?>
  html +='                                 <option value="<?php echo $banner['ecbanner_id'] ?>"><?php echo $banner['name']; ?></option>';
                                  <?php
                                }
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='<tr>';
  html +='                      <td><?php echo $this->language->get("entry_limit"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][limit]" value="<?php echo $default['limit']; ?>" size="10" /></td>';
  html +='                    </tr>';
  html +='<tr>';
  html +='                      <td><?php echo $this->language->get("entry_random_slider"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][random_mode]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                ?>
  html +='                                <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';
                                  <?php
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='                     <tr>';
  html +='                      <td><?php echo $this->language->get("entry_module_width"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][module_width]" value="<?php echo $default['module_width']; ?>" size="10" /></td>';
  html +='                    </tr>';
  html +='                     <tr>';
  html +='                      <td><?php echo $this->language->get("entry_module_height"); ?></td>'
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][module_height]" value="<?php echo $default['module_height']; ?>" size="10" /></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_main_width"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][main_width]" value="<?php echo $default['main_width']; ?>" size="10" /></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_main_height"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][main_height]" value="<?php echo $default['main_height']; ?>" size="10" /></td>';
  html +='                    </tr>';
  html +='                     <tr>';
  html +='                      <td><?php echo $this->language->get("entry_thumbnail_width"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][thumbnail_width]" value="<?php echo $default['thumbnail_width']; ?>" size="10" /></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_thumbnail_height"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][thumbnail_height]" value="<?php echo $default['thumbnail_height']; ?>" size="10" /></td>';
  html +='                    </tr>';
  html +='<tr>';
  html +='                      <td><?php echo $this->language->get("entry_resize_type"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][resize_type]">';
                            <?php 
                             if($resiztypes){
                              foreach($resiztypes as $key=>$val){
                                ?>
  html +='                           <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';
                                  <?php
                                
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='<tr>';
  html +='                      <td colspan="2"><b><?php echo $this->language->get("entry_slider_caption"); ?></b></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_show_caption"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][show_caption]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['show_caption']){
                                ?>
  html +='                                <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                <?php
                                }else{
                                  ?>
  html +='                                <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';
                                  <?php
                                }
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_caption_effect"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][caption_effect]">';
                            <?php 
                             if($caption_effects){
                              foreach($caption_effects as $val){
                                if($val == $default['caption_effect']){
                                ?>
  html +='                                <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>';
                                <?php
                                }else{
                                  ?>
  html +='                                <option value="<?php echo $val; ?>"><?php echo $val; ?></option>';
                                  <?php
                                }
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='<tr>';
  html +='                      <td><?php echo $this->language->get("entry_show_product_info"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][show_product_info]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['show_product_info']){
                                ?>
  html +='                                <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                <?php
                                }else{
                                  ?>
  html +='                                <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';
                                  <?php
                                }
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_title_max_chars"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][title_max_chars]" value="<?php echo $default['title_max_chars']; ?>" size="10" /></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_description_max_chars"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][description_max_chars]" value="<?php echo $default['description_max_chars']; ?>" size="10" /></td>';
  html +='                    </tr>';
  html +='<tr>';
  html +='                      <td><?php echo $this->language->get("entry_caption_background_color"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][background_color]" value="" class="picker" id="background_color_'+module_row+'"/></td>';
  html +='                   </tr>';
  html +='                     <tr>';
  html +='                      <td><?php echo $this->language->get("entry_caption_text_color"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][text_color]" value="" class="picker" id="text_color_'+module_row+'" /></td>';
  html +='                    </tr>';
  html +='                     <tr>';
  html +='                      <td><?php echo $this->language->get("entry_caption_link_color"); ?></td>';
  html +='                      <td><input type="text" name="ecslideshow_module['+module_row+'][link_color]" value="" class="picker" id="link_color_'+module_row+'"/></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td colspan="2"><b><?php echo $this->language->get("entry_slider_effect"); ?></b></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_skin"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][skin]">';
                            <?php 
                             if($skins){
                              foreach($skins as $skin){
                                $skin_name = str_replace("_", " ", $skin);
                                if($skin == $default['skin']){
                                  ?>
   html +='                    <option value="<?php echo $skin; ?>" selected="selected"><?php echo $skin_name; ?></option>';                                
                                  <?php
                                }else{
                                ?>
  html +='                                <option value="<?php echo $skin; ?>"><?php echo $skin_name; ?></option>';
                                  <?php
                                }
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_alignment"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][alignment]">';
                            <?php 
                             if($alignments){
                              foreach($alignments as $key){
                                if($key == $default['alignment']):
                                ?>
  html +='                                <option value="<?php echo $key; ?>" selected="selected"><?php echo $key; ?></option>';
                                  <?php
                                else:?>
  html +='                                <option value="<?php echo $key; ?>"><?php echo $key; ?></option>';
                                  <?php

                                endif;
                                
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_auto_advance"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][auto_advance]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['auto_advance']):
                                ?>
  html +='                                <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                  ?>
  html +='                                <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';
                                <?php
                                endif;
                                
                              }
                             }
                            ?>
  html +='                        </select></td>';
  html +='                    </tr>';
  html +='                    <tr>';
  html +='                      <td><?php echo $this->language->get("entry_mobile_auto_advance"); ?></td>';
  html +='                      <td><select name="ecslideshow_module['+module_row+'][mobile_auto_advance]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['mobile_auto_advance']):
                                ?>
    html +='                              <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                ?>
    html +='                              <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';                          
                              <?php
                                  endif;
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_bar_direction"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][bar_direction]">';
                            <?php 
                             if($directions){
                              foreach($directions as $val){
                                if($val == $default['bar_direction']):
                                ?>
    html +='                              <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                ?>
    html +='                              <option value="<?php echo $val; ?>"><?php echo $val; ?></option>';                          
                                <?php
                                  endif;
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +=' <tr>';
    html +='                    <td><?php echo $this->language->get("entry_bar_position"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][bar_position]">';
                            <?php 
                             if($bar_positions){
                              foreach($bar_positions as $val){
                                if($val == $default['bar_position']){
                                ?>
    html +='                              <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>';
                                <?php
                                }else{
                                  ?>
    html +='                              <option value="<?php echo $val; ?>"><?php echo $val; ?></option>';
                                  <?php
                                }
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +=' <tr>';
    html +='                    <td><?php echo $this->language->get("entry_slide_height"); ?></td>';
    html +='                    <td><input type="text" name="ecslideshow_module['+module_row+'][height]" value="<?php echo $default['height']; ?>" size="10" /></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_min_height"); ?></td>';
    html +='                    <td><input type="text" name="ecslideshow_module['+module_row+'][min_height]" value="<?php echo $default['min_height']; ?>" size="10" /></td>';
    html +='                  </tr>';
    html +='                   <tr>';
    html +='                    <td><?php echo $this->language->get("entry_cols"); ?></td>';
    html +='                    <td><input type="text" name="ecslideshow_module['+module_row+'][cols]" value="<?php echo $default['cols']; ?>" size="10" /></td>';
    html +='                  </tr>';
    html +='                   <tr>';
    html +='                    <td><?php echo $this->language->get("entry_rows"); ?></td>';
    html +='                    <td><input type="text" name="ecslideshow_module['+module_row+'][rows]" value="<?php echo $default['rows']; ?>" size="10" /></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_easing"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][easing]">';
                            <?php 
                             if($easings){
                              foreach($easings as $val){
                                if($val == $default['easing']):
                                ?>
    html +='                              <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php 
                                else:
                                  ?>
    html +='                              <option value="<?php echo $val; ?>"><?php echo $val; ?></option>';                            
                                <?php
                                endif;      
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_fx"); ?></td>';
    html +='                    <td><select multiple="multiple" name="ecslideshow_module['+module_row+'][fx][]" size="10">';
                            <?php 
                             if($effects){
                              foreach($effects as $val){
                                if($val == $default['fx']):
                                ?>
    html +='                              <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                  ?>
    html +='                              <option value="<?php echo $val; ?>"><?php echo $val; ?></option>';                            
                                <?php
                                  endif;
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_hover"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][hover]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['hover']):
                                ?>
    html +='                              <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                ?>
    html +='                              <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';                          
                              <?php
                                  endif;
                                
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_loader"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][loader]">';
                            <?php 
                             if($loaders){
                              foreach($loaders as $val){
                                if($val == $default['loader']):
                                ?>
    html +='                              <option value="<?php echo $val; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                  ?>
    html +='                              <option value="<?php echo $val; ?>"><?php echo $val; ?></option>';                            
                                <?php
                                endif;
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_navigation"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][navigation]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['navigation']):
                                ?>
    html +='                              <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                ?>
    html +='                              <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';                          
                              <?php
                                  endif;
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_navigation_hover"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][navigation_hover]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['navigation_hover']):
                                ?>
    html +='                              <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                  ?>
    html +='                              <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';                            
                                <?php
                                endif;
                                
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_pagination"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][pagination]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['pagination']):
                                ?>
    html +='                              <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                  ?>
    html +='                              <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';                            
                                <?php
                                  endif;
                                
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_play_pause"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][play_pause]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['play_pause']):
                                ?>
    html +='                              <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                ?>
    html +='                              <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';                          
                              <?php
                                  endif;
                              }
                             }
                            ?>
    html +='                      </select></td>';
    html +='                  </tr>';
    html +='                  <tr>';
    html +='                    <td><?php echo $this->language->get("entry_thumbnails"); ?></td>';
    html +='                    <td><select name="ecslideshow_module['+module_row+'][thumbnails]">';
                            <?php 
                             if($yesno){
                              foreach($yesno as $key=>$val){
                                if($key == $default['thumbnails']):
                                ?>
    html +='                              <option value="<?php echo $key; ?>" selected="selected"><?php echo $val; ?></option>';
                                  <?php
                                else:
                                  ?>
    html +='                              <option value="<?php echo $key; ?>"><?php echo $val; ?></option>';                            
                                <?php
                                  endif;
                              }
                             }
                            ?>
    html +='                    </select></td>';
    html +='                </tr>';
    html +='                 <tr>';
    html +='                  <td><?php echo $this->language->get("entry_time"); ?></td>';
    html +='                  <td><input type="text" name="ecslideshow_module['+module_row+'][time]" value="<?php echo $default['time']; ?>" size="10" /></td>';
    html +='                </tr>';
    html +='                 <tr>';
    html +='                  <td><?php echo $this->language->get("entry_trans_period"); ?></td>';
    html +='                  <td><input type="text" name="ecslideshow_module['+module_row+'][trans_period]" value="<?php echo $default['trans_period']; ?>" size="10" /></td>';
    html +='                </tr>';
    html +='        </table>';
    html +='      </div>';
  
  $('#form').append(html);
  
  $('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_block; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
  
  $('.vtabs a').tabs();
  $('#language-general a').tabs();
  $('#module-' + module_row).trigger('click');

  $('#background_color_' + module_row).colpick({
    layout:'hex',
    submit:0,
    colorScheme:'dark',
    onChange:function(hsb,hex,rgb,fromSetColor) {
      var tmp_module_row = module_row - 1;
      if(!fromSetColor) $('#background_color_' + tmp_module_row).val(hex).css('border-color','#'+hex);
    }
  }).keyup(function(){
    $(this).colpickSetColor(this.value);
  });

  $('#text_color_' + module_row).colpick({
    layout:'hex',
    submit:0,
    colorScheme:'dark',
    onChange:function(hsb,hex,rgb,fromSetColor) {
      var tmp_module_row = module_row - 1;
      if(!fromSetColor) $('#text_color_' + tmp_module_row).val(hex).css('border-color','#'+hex);
    }
  }).keyup(function(){
    $(this).colpickSetColor(this.value);
  });

  $('#link_color_' + module_row).colpick({
    layout:'hex',
    submit:0,
    colorScheme:'dark',
    onChange:function(hsb,hex,rgb,fromSetColor) {
      var tmp_module_row = module_row - 1;
      if(!fromSetColor) $('#link_color_' + tmp_module_row).val(hex).css('border-color','#'+hex);
    }
  }).keyup(function(){
    $(this).colpickSetColor(this.value);
  });

  module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();

//--></script>
<script type="text/javascript"><!--
$('#language-general a').tabs();
//--></script>
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#background_color_<?php echo $module_row;?>').colpick({
  layout:'hex',
  submit:0,
  colorScheme:'dark',
  color: $('#background_color_<?php echo $module_row;?>').val(),
  onChange:function(hsb,hex,rgb,fromSetColor) {
    if(!fromSetColor) $('#background_color_<?php echo $module_row;?>').val(hex).css('border-color','#'+hex);
  }
}).keyup(function(){
  $(this).colpickSetColor(this.value);
});

$('#text_color_<?php echo $module_row;?>').colpick({
  layout:'hex',
  submit:0,
  colorScheme:'dark',
  color: $('#text_color_<?php echo $module_row;?>').val(),
  onChange:function(hsb,hex,rgb,fromSetColor) {
    if(!fromSetColor) $('#text_color_<?php echo $module_row;?>').val(hex).css('border-color','#'+hex);
  }
}).keyup(function(){
  $(this).colpickSetColor(this.value);
});

$('#link_color_<?php echo $module_row;?>').colpick({
  layout:'hex',
  submit:0,
  colorScheme:'dark',
  color: $('#link_color_<?php echo $module_row;?>').val(),
  onChange:function(hsb,hex,rgb,fromSetColor) {
    if(!fromSetColor) $('#link_color_<?php echo $module_row;?>').val(hex).css('border-color','#'+hex);
  }
}).keyup(function(){
  $(this).colpickSetColor(this.value);
});
<?php $module_row++; ?>
<?php } ?> 
//--></script>
<?php echo $footer; ?>
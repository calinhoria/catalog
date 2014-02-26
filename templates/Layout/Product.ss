<div class="left_part">
    <div class="sidebar_title">
        $Level(1).Title
    </div>
    <% loop Level(1).Children %>
    <div class="sidebar_block">
        <div class="block_title">
            $Title
        </div>
        <% if Children %>
        <ul class="subcategory_container">
            <% loop Children %>
            <% if not Children %>
            <li class="subcategory">
                <input type="checkbox"  id="category_$ID" />
                <label for="category_$ID">$Title</label>
            </li>
            <% else %>
            <label  class="sucategory_parent">$Title</label>
            <br />
            <ul>
                <% loop Children %>
                <li class="subcategory">
                    <input type="checkbox"  id="category_$ID" />
                    <label for="category_$ID">$Title</label>
                </li>
                <% end_loop %>
            </ul>
            <% end_if %>
            <% end_loop %>
            <% end_if %>
        </ul>
    </div>
    <% end_loop %>
</div>
<div class="right_part">
    <div class="product_content">
        <div class="product_image">
        <img class="main_image" style="margin-bottom: 10px" src="$Thumbnail.CroppedImage(386,241).URL" />
        <div class="gallery_image_item">
         <img style="opacity: 1" src="$Thumbnail.CroppedImage(126,95).URL" full-url="$Thumbnail.CroppedImage(386,241).URL" />
         </div>
        <% loop GalleryImages %>
        	<% with Image %>
        	<div class="gallery_image_item">
        	   <img src="$CroppedImage(126,95).URL" full-url="$CroppedImage(386,241).URL" />
        	   </div>
        	<% end_with %>
        <% end_loop %>
        <div style="clear: both"></div>
        </div>
        <div class="product_detail">
        <div class="product_title">
        $Title
        </div>
        <div class="lines"></div>
        <div class="content">
        $Content
        </div>
        </div>
        <div style="clear: both"></div>
    </div>
<div class="product_share"></div>
<div class="related_products ProductCategory">
$Parent.Parent.Products.Count
<% loop Parent.Children %>

    <a href="$Link">
    <div class="product_item">
        <% with Thumbnail  %>
        <% with $CroppedImage(218,220) %>
        <img src="$URL" width="{$Width}px" height="{$Height}px" style="width: {$Width}px;{$Height}px" />
        <% end_with %>
        <% end_with %>
        <div class="product_title">
            $Title
        </div>
        <div class="product_summary">
            $Content.Summary(10)
        </div>
    </div>
    </a>
<% end_loop %>
</div>
<div class="product_form"></div>
</div>
<script>
	jQuery(document).ready(function($) {
		$(".sucategory_parent").next().next().each(function(k, v) {
			$(v).hide();
		});
		$(".sucategory_parent").click(function() {
			$(this).next().next().toggle("fast");
		});
		$(".gallery_image_item img").not(':first').css("opacity","0.5");
		$(".gallery_image_item img").hover(function() {
		    $(".gallery_image_item img").css("opacity","0.5");
			$(".main_image").attr("src",$(this).attr("full-url"));
			 $(this).css("opacity","1");
		}, function() {

		});

	});
</script>
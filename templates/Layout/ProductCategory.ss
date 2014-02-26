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
    <% if Parent  %>
    <% loop Products %>
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
    <div style="clear: both"></div>
    <br />
    <% else %>
    <% loop getCategories %>
    <div class="category_title">
        $Title
    </div>
    <div class="lines"></div>
    <% loop Children %>
    <div class="category_container">

        <% with Thumbnail  %>
        <% with setSize(154,110) %>
        <img src="$URL" width="$Width" height="$Height" style="width: {$Width}px;{$Height}px" />
        <% end_with %>
        <% end_with %>

        <div title="$Title" class="title">
            $Title
        </div>

    </div>
    <% end_loop %>
    <div style="clear: both"></div>
    <br />
    <% end_loop %>
    <% end_if %>
    <% if Parent  %>
    <div class="pagination">
        <% if $Products.MoreThanOnePage %>
        <% if $Products.NotFirstPage %>
        <a class="prev" href="$Products.PrevLink">< <span><% _t("PREV","Previous") %> </span></a>
        <% end_if %>
        <% loop $Products.Pages %>
        <% if $CurrentBool %>
        <a class="current">$PageNum</a>
        <% else %>
        <% if $Link %>
        <a href="$Link">$PageNum</a>
        <% else %>
        <a>...</a>
        <% end_if %>
        <% end_if %>
        <% end_loop %>
        <% if $Products.NotLastPage %>
        <a class="next" href="$Products.NextLink"><span><% _t("NEXT","Next") %></span> ></a>
        <% end_if %>
        <% end_if %>
    </div>
    <% end_if %>
</div>
<div style="clear: both"></div>
<script>
	jQuery(document).ready(function($) {
		$(".sucategory_parent").next().next().each(function(k, v) {
			$(v).hide();
		});
		$(".sucategory_parent").click(function() {
			$(this).next().next().toggle("fast");
		});
	});
    </script>
<style>
    .pagination {

        text-align: right;
    }
    .pagination a {
        padding-left: 6px;
        padding-right: 6px;
        line-height: 17px;
        border: 1px solid #747474;
        font-family: PT Sans;
        font-size: 10px;
        font-style: italic;
        display: inline-block;
        text-align: center;
        color: #747474;
    }
    .pagination a span {
        font-family: Calibri;
        font-size: 15px;
        color: #747474;
    }
    .pagination a.current, .pagination a:hover {
        background-color: #f00;
        color: #fff;
        text-decoration: none;
        border-bottom: 1px solid #747474;
    }
    .pagination a span:hover {
        color: #fff;
    }
    .pagination .prev, .pagination .prev:hover {
        border: 0;
    }
    .pagination .next, .pagination .next:hover {
        border: 0;
    }
    .pagination {
        border-top: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
        line-height: 40px;
    }
</style>
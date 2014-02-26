<?php
class ProductCategory extends Page
{
static $icon="catalog/images/category.png";
    static $allowed_children = array("Product","ProductCategory");
 static $belongs_many_many = array(
		'Products' => 'Product'
	);
     static $has_one = array('Thumbnail' => 'Image', );

	private static $singular_name = "Category";
	private static $plural_name = "Categories";
	private static $default_child = 'Product';
	private static $include_child_groups = true;
	private static $page_length = 3;
    static $db = array(

    );
	// public function updateSettingsFields(FieldList $fields) {
		// if($this->attachedToSiteTree()) {
			// $fields->addFieldToTab('Root.Settings',
				// new CheckboxField('ProvideComments', _t('Comment.ALLOWCOMMENTS', 'Allow Comments'))
			// );
		// }
	// }
	public function ProductsShowable($recursive = true){
		// Figure out the categories to check
		$groupids = array($this->ID);
		if(!empty($recursive) && self::config()->include_child_groups) {
			$groupids += $this->AllChildCategoryIDs();
		}
		$products = Product::get()
			->leftJoin('Product_ProductCategories', '"Product_ProductCategories"."ProductID" = "Product"."ID"')
			->filterAny(array(
				'ParentID' => $groupids,
				'Product_ProductCategories.ProductCategoryID' => $groupids
			));

		return $products;
	}
	public function AllChildCategoryIDs(){
		$ids = array($this->ID);
		$allids = array();
		do{
			$ids = ProductCategory::get()
				->filter('ParentID', $ids)
				->getIDList();
			$allids += $ids;
		}while(!empty($ids));

		return $allids;
	}
	public function ChildCategories($recursive = false) {
		$children = ProductCategory::get()->filter("ParentID",$this->ID);
		if($recursive){
			$children = $children->filter("ParentID",$this->AllChildCategoryIDs());
		}

		return $children;
	}
    public function getCategories()
    {
        if (isset($_GET["categories"])) {

        }
        else {
            return $this->ChildCategories();
        }
    }

	public function GroupsMenu() {
		if($this->Parent() instanceof ProductCategory){

			return $this->Parent()->GroupsMenu();
		}
		return ProductCategory::get()
			->filter("ParentID",$this->ID);
	}


	public function NestedTitle($level = 10, $separator = " > ", $field = "MenuTitle") {
		$item = $this;
		while($item && $level > 0) {
			$parts[] = $item->{$field};
			$item = $item->Parent;
			$level--;
		}
		return implode($separator, array_reverse($parts));
	}

    function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields -> addFieldToTab('Root.Main', new UploadField("Thumbnail", _t("CATEGORY_IMAGE","Set category image")));

        return $fields;
    }

    static $has_many = array();

    function ProductsList()
    {
        $lenght =12;
        $ProductsList = DataObject::get('ProductsPage', "ParentID = $this->ID");
        $pagingProducts = new PaginatedList($ProductsList, Controller::curr() -> request);
        $pagingProducts -> setPageLength($lenght);

        return $pagingProducts;
    }


}

class ProductCategory_Controller extends Page_Controller
{
     function init() {
             parent::init();
         }
/**
	 * Return the products for this group.
	 */
	public function Products($recursive = true){
		$products = $this->ProductsShowable($recursive);
		//sort the products

		//paginate the products
		$products = new PaginatedList($products, $this->request);
		$products->setPageLength(3);
		$products->TotalCount = $products->getTotalItems();

		return $products;
	}
}

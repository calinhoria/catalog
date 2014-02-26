<?php
class Product extends Page
{
    static $icon = "catalog/images/product.png";
    static $db = array();
    private static $singular_name = "Product";
    private static $plural_name = "Products";
    static $has_one = array('Thumbnail' => 'Image', );
    private static $defaults = array("ShowInMenus" => 0, );
    private static $allowed_children = "none";

    static $can_be_root = false;

    private static $many_many = array('ProductCategories' => 'ProductCategory');
    function getCMSFields()
    {
        $fields = parent::getCMSFields();
        $fields -> addFieldToTab('Root.Main', new UploadField("Thumbnail", "Set product image"));
        $fields -> addFieldsToTab("Root.Main", array(
            DropdownField::create('ParentID', _t("Product.CATEGORY", "Category"), $this -> categoryoptions()) -> setDescription(_t("Product.CATEGORYDESCRIPTION", "This is the parent page or default category.")),
            ListBoxField::create('ProductCategories', _t("Product.ADDITIONALCATEGORIES", "Additional Categories"), ProductCategory::get() -> map('ID', 'NestedTitle') -> toArray()) -> setMultiple(true),
        ));
        return $fields;
    }

    private function categoryoptions()
    {
        $categories = ProductCategory::get() -> map('ID', 'NestedTitle') -> toArray();
        $categories = array(0 => _t("SiteTree.PARENTTYPE_ROOT", "Top-level page")) + $categories;

        if ($this -> ParentID && !($this -> Parent() instanceof ProductCategory))
        {
            $categories = array($this -> ParentID => $this -> Parent() -> Title . " (" . $this -> Parent() -> i18n_singular_name() . ")") + $categories;
        }

        return $categories;
    }

}

class Product_Controller extends Page_Controller
{

}

/*
 Navicat Premium Data Transfer

 Source Server         : sql
 Source Server Type    : SQLite
 Source Server Version : 3017000
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3017000
 File Encoding         : 65001

 Date: 03/03/2024 22:06:07
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS "admins";
CREATE TABLE "admins" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "first_name" text(256),
  "last_name" text(256),
  "account" text(256),
  "password" text(256),
  "phone" text(255),
  "email" text(256),
  "role" text(256),
  "created_at" text(6),
  "updated_at" text(6),
  "deleted_at" text(6)
);

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO "admins" VALUES (5, 'Admin', 'A.', 'admin', '$2a$10$sYxDw.k1IaRHBGNKGURmWu4NPcpxEpnMax06KislT/.etVXoVEqOu', NULL, 'admin@admin.com', 'admin', '2024-02-26 03:37:28.327000', '2024-02-26 03:37:28.327000', NULL);
INSERT INTO "admins" VALUES (6, 'Manager', 'M.', 'manager', '$2a$10$U.pCRakwZU6E0ve4zff4O.jjlSh3y4liz3QP4Sw6GdlV37yQMhASu', NULL, 'manager@manager.com', 'manager', '2024-02-26 03:37:28.374000', '2024-02-26 03:37:28.374000', NULL);
INSERT INTO "admins" VALUES (7, 'Customer', 'C.', 'customer', '$2a$10$0cUf8sgXqowfZemvtblBDu.XA1tc20gn/oER7ibPRyfcueStjDDRm', NULL, 'customer@customer.com', 'customer', '2024-02-26 03:37:28.420000', '2024-02-26 03:37:28.420000', NULL);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS "categories";
CREATE TABLE "categories" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" integer,
  "updated_at" integer,
  "deleted_at" integer,
  "title" text,
  "slug" text,
  "excerpt" text,
  "description" text,
  "meta_keywords" text,
  "meta_description" text,
  "published" numeric,
  "parent_id" integer,
  "class" text,
  "ord" integer,
  CONSTRAINT "fk_categories_children" FOREIGN KEY ("parent_id") REFERENCES "categories" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO "categories" VALUES (1, '2024-03-03 21:57:48.52529+08:00', '2024-03-03 21:57:48.52529+08:00', NULL, 'Product Category 1', 'product-category-1', '', 'Category description goes here', '', '', 1, NULL, '', 0);

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS "images";
CREATE TABLE "images" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" integer,
  "updated_at" integer,
  "deleted_at" integer,
  "url" text,
  "product_id" integer,
  CONSTRAINT "fk_products_images" FOREIGN KEY ("product_id") REFERENCES "products" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- ----------------------------
-- Table structure for menu_items
-- ----------------------------
DROP TABLE IF EXISTS "menu_items";
CREATE TABLE "menu_items" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" integer,
  "updated_at" integer,
  "deleted_at" integer,
  "title" text,
  "url" text,
  "ord" integer,
  "parent_id" integer,
  "class" text,
  "menu_id" integer,
  CONSTRAINT "fk_menus_items" FOREIGN KEY ("menu_id") REFERENCES "menus" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT "fk_menu_items_children" FOREIGN KEY ("parent_id") REFERENCES "menu_items" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- ----------------------------
-- Records of menu_items
-- ----------------------------
INSERT INTO "menu_items" VALUES (1, '2024-03-03 21:57:48.5315478+08:00', '2024-03-03 21:57:48.5315478+08:00', NULL, 'Home', '/', 1, NULL, '', 1);
INSERT INTO "menu_items" VALUES (2, '2024-03-03 21:57:48.5336248+08:00', '2024-03-03 21:57:48.5336248+08:00', NULL, 'About', '/pages/2-about-mix', 2, NULL, '', 1);
INSERT INTO "menu_items" VALUES (3, '2024-03-03 21:57:48.5352367+08:00', '2024-03-03 21:57:48.5352367+08:00', NULL, 'Lorem Ipsum 1', '#', 1, NULL, '', 2);
INSERT INTO "menu_items" VALUES (4, '2024-03-03 21:57:48.5352367+08:00', '2024-03-03 21:57:48.5352367+08:00', NULL, 'Subitem 1', '/', 1, 3, '', 2);
INSERT INTO "menu_items" VALUES (5, '2024-03-03 21:57:48.5372428+08:00', '2024-03-03 21:57:48.5372428+08:00', NULL, 'Lorem Ipsum 2', '#', 2, NULL, '', 2);
INSERT INTO "menu_items" VALUES (6, '2024-03-03 21:57:48.538248+08:00', '2024-03-03 21:57:48.538248+08:00', NULL, 'Subitem 2', '/', 1, 5, '', 2);
INSERT INTO "menu_items" VALUES (7, '2024-03-03 21:57:48.5387601+08:00', '2024-03-03 21:57:48.5387601+08:00', NULL, 'Lorem Ipsum 3', '#', 3, NULL, '', 2);
INSERT INTO "menu_items" VALUES (8, '2024-03-03 21:57:48.5387601+08:00', '2024-03-03 21:57:48.5387601+08:00', NULL, 'Subitem 3', '/', 1, 7, '', 2);
INSERT INTO "menu_items" VALUES (9, '2024-03-03 21:57:48.5387601+08:00', '2024-03-03 21:57:48.5387601+08:00', NULL, 'Lorem Ipsum 4', '#', 4, NULL, '', 2);
INSERT INTO "menu_items" VALUES (10, '2024-03-03 21:57:48.5387601+08:00', '2024-03-03 21:57:48.5387601+08:00', NULL, 'Subitem 4', '/', 1, 9, '', 2);

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS "menus";
CREATE TABLE "menus" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" integer,
  "updated_at" integer,
  "deleted_at" integer,
  "code" text,
  "title" text
);

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO "menus" VALUES (1, '2024-03-03 21:57:48.5273792+08:00', '2024-03-03 21:57:48.5273792+08:00', NULL, 'main', 'Main menu');
INSERT INTO "menus" VALUES (2, '2024-03-03 21:57:48.5294459+08:00', '2024-03-03 21:57:48.5294459+08:00', NULL, 'footer', 'Footer menu');

-- ----------------------------
-- Table structure for order_products
-- ----------------------------
DROP TABLE IF EXISTS "order_products";
CREATE TABLE "order_products" (
  "order_id" integer(20) NOT NULL,
  "product_id" integer(20) NOT NULL,
  PRIMARY KEY ("order_id", "product_id")
);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS "orders";
CREATE TABLE "orders" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "created_at" text NOT NULL,
  "updated_at" text NOT NULL,
  "deleted_at" text,
  "first_name" text(255),
  "middle_name" text(255),
  "last_name" text(255),
  "email" text(255),
  "phone" text(255),
  "comment" text
);

-- ----------------------------
-- Table structure for pages
-- ----------------------------
DROP TABLE IF EXISTS "pages";
CREATE TABLE "pages" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" integer,
  "updated_at" integer,
  "deleted_at" integer,
  "title" text,
  "description" text,
  "slug" text,
  "published" numeric,
  "meta_keywords" text,
  "meta_description" text
);

-- ----------------------------
-- Records of pages
-- ----------------------------
INSERT INTO "pages" VALUES (1, '2024-03-03 21:54:13.6337595+08:00', '2024-03-03 21:54:13.6337595+08:00', NULL, 'Welcome To MIX Skeleton Project', '
			<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.</p>
			<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>
			', 'welcome-to-mix-skeleton-project', 0, '', '');
INSERT INTO "pages" VALUES (2, '2024-03-03 21:54:13.6387992+08:00', '2024-03-03 21:54:13.6387992+08:00', NULL, 'About MIX', 'MIX is a skeleton project for basic e-shop web-sites. It demonstrates user authentication, 3 user roles: admin, manager & customer, product cart & checkout, email notifications, user dashboard for all roles, some ui animations via Animate On Scroll library, bootstrap 4 template, home page carousel and may be something more...', 'about-mix', 1, '', '');
INSERT INTO "pages" VALUES (3, 1709474625, 1709474625, NULL, 'Welcome To MIX Skeleton Project', '
			<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.</p>
			<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>
			', 'welcome-to-mix-skeleton-project', 0, '', '');
INSERT INTO "pages" VALUES (4, 1709474625, 1709474625, NULL, 'About MIX', 'MIX is a skeleton project for basic e-shop web-sites. It demonstrates user authentication, 3 user roles: admin, manager & customer, product cart & checkout, email notifications, user dashboard for all roles, some ui animations via Animate On Scroll library, bootstrap 4 template, home page carousel and may be something more...', 'about-mix', 1, '', '');
INSERT INTO "pages" VALUES (5, 1709474636, 1709474636, NULL, 'Welcome To MIX Skeleton Project', '
			<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.</p>
			<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>
			', 'welcome-to-mix-skeleton-project', 0, '', '');
INSERT INTO "pages" VALUES (6, 1709474636, 1709474636, NULL, 'About MIX', 'MIX is a skeleton project for basic e-shop web-sites. It demonstrates user authentication, 3 user roles: admin, manager & customer, product cart & checkout, email notifications, user dashboard for all roles, some ui animations via Animate On Scroll library, bootstrap 4 template, home page carousel and may be something more...', 'about-mix', 1, '', '');
INSERT INTO "pages" VALUES (7, 1709474714, 1709474714, NULL, 'Welcome To MIX Skeleton Project', '
			<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.</p>
			<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>
			', 'welcome-to-mix-skeleton-project', 0, '', '');
INSERT INTO "pages" VALUES (8, 1709474714, 1709474714, NULL, 'About MIX', 'MIX is a skeleton project for basic e-shop web-sites. It demonstrates user authentication, 3 user roles: admin, manager & customer, product cart & checkout, email notifications, user dashboard for all roles, some ui animations via Animate On Scroll library, bootstrap 4 template, home page carousel and may be something more...', 'about-mix', 1, '', '');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS "products";
CREATE TABLE "products" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "created_at" integer,
  "updated_at" integer,
  "deleted_at" integer,
  "title" text,
  "description" text,
  "meta_keywords" text,
  "meta_description" text,
  "category_id" integer(20),
  "published" numeric,
  "slug" text,
  "default_image_id" integer(20),
  "recommended" numeric,
  CONSTRAINT "fk_products_category" FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO "products" VALUES (1, '2024-02-26 03:37:10.978', '2024-02-26 03:37:10.978', NULL, 'Demo product 0', 'Product description goes here', '', '', 1, 1, 'demo-product-0', 0, 1);
INSERT INTO "products" VALUES (2, '2024-02-26 03:37:10.981', '2024-02-26 03:37:10.981', NULL, 'Demo product 1', 'Product description goes here', '', '', 1, 1, 'demo-product-1', 0, 1);
INSERT INTO "products" VALUES (3, '2024-02-26 03:37:10.984', '2024-02-26 03:37:10.984', NULL, 'Demo product 2', 'Product description goes here', '', '', 1, 1, 'demo-product-2', 0, 1);
INSERT INTO "products" VALUES (4, '2024-02-26 03:37:10.985', '2024-02-26 03:37:10.985', NULL, 'Demo product 3', 'Product description goes here', '', '', 1, 1, 'demo-product-3', 0, 1);
INSERT INTO "products" VALUES (5, '2024-02-26 03:37:10.986', '2024-02-26 03:37:10.986', NULL, 'Demo product 4', 'Product description goes here', '', '', 1, 1, 'demo-product-4', 0, 1);
INSERT INTO "products" VALUES (6, '2024-02-26 03:37:10.988', '2024-02-26 03:37:10.988', NULL, 'Demo product 5', 'Product description goes here', '', '', 1, 1, 'demo-product-5', 0, 1);
INSERT INTO "products" VALUES (7, '2024-02-26 03:37:10.989', '2024-02-26 03:37:10.989', NULL, 'Demo product 6', 'Product description goes here', '', '', 1, 1, 'demo-product-6', 0, 1);
INSERT INTO "products" VALUES (8, '2024-02-26 03:37:10.990', '2024-02-26 03:37:10.990', NULL, 'Demo product 7', 'Product description goes here', '', '', 1, 1, 'demo-product-7', 0, 1);
INSERT INTO "products" VALUES (9, '2024-02-26 03:37:10.990', '2024-02-26 03:37:10.990', NULL, 'Demo product 8', 'Product description goes here', '', '', 1, 1, 'demo-product-8', 0, 1);
INSERT INTO "products" VALUES (10, '2024-02-26 03:37:10.992', '2024-02-26 03:37:10.992', NULL, 'Demo product 9', 'Product description goes here', '', '', 1, 1, 'demo-product-9', 0, 1);
INSERT INTO "products" VALUES (11, '2024-02-26 03:37:10.994', '2024-02-26 03:37:10.994', NULL, 'Demo product 10', 'Product description goes here', '', '', 1, 1, 'demo-product-10', 0, 1);
INSERT INTO "products" VALUES (12, '2024-02-26 03:37:10.994', '2024-02-26 03:37:10.994', NULL, 'Demo product 11', 'Product description goes here', '', '', 1, 1, 'demo-product-11', 0, 1);
INSERT INTO "products" VALUES (13, '2024-02-26 03:37:10.996', '2024-02-26 03:37:10.996', NULL, 'Demo product 12', 'Product description goes here', '', '', 1, 1, 'demo-product-12', 0, 1);
INSERT INTO "products" VALUES (14, '2024-02-26 03:37:10.997', '2024-02-26 03:37:10.997', NULL, 'Demo product 13', 'Product description goes here', '', '', 1, 1, 'demo-product-13', 0, 1);
INSERT INTO "products" VALUES (15, '2024-02-26 03:37:11.002', '2024-02-26 03:37:11.002', NULL, 'Demo product 14', 'Product description goes here', '', '', 1, 1, 'demo-product-14', 0, 1);
INSERT INTO "products" VALUES (16, '2024-02-26 03:37:11.004', '2024-02-26 03:37:11.004', NULL, 'Demo product 15', 'Product description goes here', '', '', 1, 1, 'demo-product-15', 0, 1);
INSERT INTO "products" VALUES (17, '2024-02-26 03:37:11.005', '2024-02-26 03:37:11.005', NULL, 'Demo product 16', 'Product description goes here', '', '', 1, 1, 'demo-product-16', 0, 1);
INSERT INTO "products" VALUES (18, '2024-02-26 03:37:11.006', '2024-02-26 03:37:11.006', NULL, 'Demo product 17', 'Product description goes here', '', '', 1, 1, 'demo-product-17', 0, 1);
INSERT INTO "products" VALUES (19, '2024-02-26 03:37:11.008', '2024-02-26 03:37:11.008', NULL, 'Demo product 18', 'Product description goes here', '', '', 1, 1, 'demo-product-18', 0, 1);
INSERT INTO "products" VALUES (20, '2024-02-26 03:37:11.009', '2024-02-26 03:37:11.009', NULL, 'Demo product 19', 'Product description goes here', '', '', 1, 1, 'demo-product-19', 0, 1);

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS "settings";
CREATE TABLE "settings" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" integer,
  "updated_at" integer,
  "deleted_at" integer,
  "code" text,
  "title" text,
  "value" text
);

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO "settings" VALUES (1, '2024-03-03 21:54:13.6179429+08:00', '2024-03-03 21:54:13.6179429+08:00', NULL, 'tel_1', 'Contact phone #1', '+1 300 33-33-33');
INSERT INTO "settings" VALUES (2, '2024-03-03 21:54:13.6194942+08:00', '2024-03-03 21:54:13.6194942+08:00', NULL, 'tel_2', 'Contact phone #2', '+1 300 43-33-33');
INSERT INTO "settings" VALUES (3, '2024-03-03 21:54:13.6215692+08:00', '2024-03-03 21:54:13.6215692+08:00', NULL, 'tel_3', 'Contact phone #3', '+1 300 53-33-33');
INSERT INTO "settings" VALUES (4, '2024-03-03 21:54:13.6236178+08:00', '2024-03-03 21:54:13.6236178+08:00', NULL, 'email', 'Contact email', 'email@example.com');
INSERT INTO "settings" VALUES (5, '2024-03-03 21:54:13.6278388+08:00', '2024-03-03 21:54:13.6278388+08:00', NULL, 'order_email', 'Email for order notifications', 'order@example.com');
INSERT INTO "settings" VALUES (6, '2024-03-03 21:54:13.6306606+08:00', '2024-03-03 21:54:13.6306606+08:00', NULL, 'title_suffix', 'Meta Title suffix', 'Awesome business skeletons');
INSERT INTO "settings" VALUES (7, '2024-03-03 21:54:13.6367203+08:00', '2024-03-03 21:54:13.6367203+08:00', NULL, 'home_id', 'Home Page ID', 1);
INSERT INTO "settings" VALUES (8, '2024-03-03 21:54:13.6408758+08:00', '2024-03-03 21:54:13.6408758+08:00', NULL, 'about_id', 'About Page ID', 2);
INSERT INTO "settings" VALUES (9, 1709474625, 1709474625, NULL, 'tel_1', 'Contact phone #1', '+1 300 33-33-33');
INSERT INTO "settings" VALUES (10, 1709474625, 1709474625, NULL, 'tel_2', 'Contact phone #2', '+1 300 43-33-33');
INSERT INTO "settings" VALUES (11, 1709474625, 1709474625, NULL, 'tel_3', 'Contact phone #3', '+1 300 53-33-33');
INSERT INTO "settings" VALUES (12, 1709474625, 1709474625, NULL, 'email', 'Contact email', 'email@example.com');
INSERT INTO "settings" VALUES (13, 1709474625, 1709474625, NULL, 'order_email', 'Email for order notifications', 'order@example.com');
INSERT INTO "settings" VALUES (14, 1709474625, 1709474625, NULL, 'title_suffix', 'Meta Title suffix', 'Awesome business skeletons');
INSERT INTO "settings" VALUES (15, 1709474625, 1709474625, NULL, 'home_id', 'Home Page ID', 3);
INSERT INTO "settings" VALUES (16, 1709474625, 1709474625, NULL, 'about_id', 'About Page ID', 4);
INSERT INTO "settings" VALUES (17, 1709474635, 1709474635, NULL, 'tel_1', 'Contact phone #1', '+1 300 33-33-33');
INSERT INTO "settings" VALUES (18, 1709474636, 1709474636, NULL, 'tel_2', 'Contact phone #2', '+1 300 43-33-33');
INSERT INTO "settings" VALUES (19, 1709474636, 1709474636, NULL, 'tel_3', 'Contact phone #3', '+1 300 53-33-33');
INSERT INTO "settings" VALUES (20, 1709474636, 1709474636, NULL, 'email', 'Contact email', 'email@example.com');
INSERT INTO "settings" VALUES (21, 1709474636, 1709474636, NULL, 'order_email', 'Email for order notifications', 'order@example.com');
INSERT INTO "settings" VALUES (22, 1709474636, 1709474636, NULL, 'title_suffix', 'Meta Title suffix', 'Awesome business skeletons');
INSERT INTO "settings" VALUES (23, 1709474636, 1709474636, NULL, 'home_id', 'Home Page ID', 5);
INSERT INTO "settings" VALUES (24, 1709474636, 1709474636, NULL, 'about_id', 'About Page ID', 6);
INSERT INTO "settings" VALUES (25, 1709474714, 1709474714, NULL, 'tel_1', 'Contact phone #1', '+1 300 33-33-33');
INSERT INTO "settings" VALUES (26, 1709474714, 1709474714, NULL, 'tel_2', 'Contact phone #2', '+1 300 43-33-33');
INSERT INTO "settings" VALUES (27, 1709474714, 1709474714, NULL, 'tel_3', 'Contact phone #3', '+1 300 53-33-33');
INSERT INTO "settings" VALUES (28, 1709474714, 1709474714, NULL, 'email', 'Contact email', 'email@example.com');
INSERT INTO "settings" VALUES (29, 1709474714, 1709474714, NULL, 'order_email', 'Email for order notifications', 'order@example.com');
INSERT INTO "settings" VALUES (30, 1709474714, 1709474714, NULL, 'title_suffix', 'Meta Title suffix', 'Awesome business skeletons');
INSERT INTO "settings" VALUES (31, 1709474714, 1709474714, NULL, 'home_id', 'Home Page ID', 7);
INSERT INTO "settings" VALUES (32, 1709474714, 1709474714, NULL, 'about_id', 'About Page ID', 8);

-- ----------------------------
-- Table structure for slides
-- ----------------------------
DROP TABLE IF EXISTS "slides";
CREATE TABLE "slides" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "created_at" text NOT NULL,
  "updated_at" text NOT NULL,
  "deleted_at" text,
  "title" text(255) NOT NULL,
  "content" text,
  "navigation_url" text(255),
  "file_url" text(255),
  "ord" integer(11)
);

-- ----------------------------
-- Records of slides
-- ----------------------------
INSERT INTO "slides" VALUES (1, '2023-12-11 18:51:52', '2023-12-11 18:51:52', NULL, 'Demo slide Title', '', '/', '/public/uploads/tables.jpg', 0);
INSERT INTO "slides" VALUES (2, '2023-12-11 18:51:52', '2023-12-11 18:51:52', NULL, 'Demo slide Title 2', '', '/', '/public/uploads/window_sills.jpg', 0);

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS "sqlite_sequence";
CREATE TABLE "sqlite_sequence" (
  "name",
  "seq"
);

-- ----------------------------
-- Records of sqlite_sequence
-- ----------------------------
INSERT INTO "sqlite_sequence" VALUES ('admins', 7);
INSERT INTO "sqlite_sequence" VALUES ('slides', 2);
INSERT INTO "sqlite_sequence" VALUES ('users', 3);
INSERT INTO "sqlite_sequence" VALUES ('pages', 8);
INSERT INTO "sqlite_sequence" VALUES ('menus', 2);
INSERT INTO "sqlite_sequence" VALUES ('menu_items', 10);
INSERT INTO "sqlite_sequence" VALUES ('categories', 1);
INSERT INTO "sqlite_sequence" VALUES ('products', 20);
INSERT INTO "sqlite_sequence" VALUES ('images', 0);
INSERT INTO "sqlite_sequence" VALUES ('settings', 32);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "users";
CREATE TABLE "users" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" integer,
  "updated_at" integer,
  "deleted_at" integer,
  "email" text,
  "first_name" text,
  "middle_name" text,
  "last_name" text,
  "password" text,
  "role" text
);

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "users" VALUES (1, '2024-03-03 21:54:13.5231993+08:00', '2024-03-03 21:54:13.5231993+08:00', NULL, 'admin@admin.com', 'Admin', 'A.', 'Admin', '$2a$10$Pf1Dcplr75BUdX4ee4ExM.p.QZbwKDHWF7VPGxmPVbBw26jT6HRAa', 'admin');
INSERT INTO "users" VALUES (2, '2024-03-03 21:54:13.56459+08:00', '2024-03-03 21:54:13.56459+08:00', NULL, 'manager@manager.com', 'Manager', 'M.', 'Manager', '$2a$10$9pYYyRPzxUYmfu4PP.FbJOuK1fh4oF/w3WalcPM5jZ5.xKorwf1PG', 'manager');
INSERT INTO "users" VALUES (3, '2024-03-03 21:54:13.6127994+08:00', '2024-03-03 21:54:13.6127994+08:00', NULL, 'customer@customer.com', 'Customer', 'C.', 'Customer', '$2a$10$Zc5JkzoF/3g.htxZ1etgoOidRzu9sIzgm0VgiRhoyzFjtflaD1EVi', 'customer');

-- ----------------------------
-- Auto increment value for admins
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 7 WHERE name = 'admins';

-- ----------------------------
-- Auto increment value for categories
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 1 WHERE name = 'categories';

-- ----------------------------
-- Auto increment value for images
-- ----------------------------

-- ----------------------------
-- Auto increment value for menu_items
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 10 WHERE name = 'menu_items';

-- ----------------------------
-- Auto increment value for menus
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 2 WHERE name = 'menus';

-- ----------------------------
-- Auto increment value for pages
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 8 WHERE name = 'pages';

-- ----------------------------
-- Auto increment value for products
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 20 WHERE name = 'products';

-- ----------------------------
-- Auto increment value for settings
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 32 WHERE name = 'settings';

-- ----------------------------
-- Auto increment value for slides
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 2 WHERE name = 'slides';

-- ----------------------------
-- Auto increment value for users
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 3 WHERE name = 'users';

PRAGMA foreign_keys = true;

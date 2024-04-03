/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100509
 Source Host           : localhost:3306
 Source Schema         : ginshop

 Target Server Type    : MySQL
 Target Server Version : 100509
 File Encoding         : 65001

 Date: 26/02/2024 03:39:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID，主键',
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `slug` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `excerpt` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `meta_keywords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `meta_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `published` tinyint(1) NULL DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `class` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `ord` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_categories_children`(`parent_id`) USING BTREE,
  CONSTRAINT `fk_categories_children` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '2023-12-11 18:51:52.292', '2023-12-11 18:51:52.292', NULL, 'Product Category 1', '', '', 'Category description goes here', '', '', 1, NULL, '', 0);

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '图片ID，主键',
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `product_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_products_images`(`product_id`) USING BTREE,
  CONSTRAINT `fk_products_images` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES (1, '2024-02-26 03:37:10.979', '2024-02-26 03:37:10.979', NULL, '/public/uploads/apple.jpg', 1);
INSERT INTO `images` VALUES (2, '2024-02-26 03:37:10.982', '2024-02-26 03:37:10.982', NULL, '/public/uploads/apple.jpg', 2);
INSERT INTO `images` VALUES (3, '2024-02-26 03:37:10.984', '2024-02-26 03:37:10.984', NULL, '/public/uploads/apple.jpg', 3);
INSERT INTO `images` VALUES (4, '2024-02-26 03:37:10.985', '2024-02-26 03:37:10.985', NULL, '/public/uploads/apple.jpg', 4);
INSERT INTO `images` VALUES (5, '2024-02-26 03:37:10.986', '2024-02-26 03:37:10.986', NULL, '/public/uploads/apple.jpg', 5);
INSERT INTO `images` VALUES (6, '2024-02-26 03:37:10.988', '2024-02-26 03:37:10.988', NULL, '/public/uploads/apple.jpg', 6);
INSERT INTO `images` VALUES (7, '2024-02-26 03:37:10.989', '2024-02-26 03:37:10.989', NULL, '/public/uploads/apple.jpg', 7);
INSERT INTO `images` VALUES (8, '2024-02-26 03:37:10.990', '2024-02-26 03:37:10.990', NULL, '/public/uploads/apple.jpg', 8);
INSERT INTO `images` VALUES (9, '2024-02-26 03:37:10.990', '2024-02-26 03:37:10.990', NULL, '/public/uploads/apple.jpg', 9);
INSERT INTO `images` VALUES (10, '2024-02-26 03:37:10.992', '2024-02-26 03:37:10.992', NULL, '/public/uploads/apple.jpg', 10);
INSERT INTO `images` VALUES (11, '2024-02-26 03:37:10.994', '2024-02-26 03:37:10.994', NULL, '/public/uploads/apple.jpg', 11);
INSERT INTO `images` VALUES (12, '2024-02-26 03:37:10.995', '2024-02-26 03:37:10.995', NULL, '/public/uploads/apple.jpg', 12);
INSERT INTO `images` VALUES (13, '2024-02-26 03:37:10.996', '2024-02-26 03:37:10.996', NULL, '/public/uploads/apple.jpg', 13);
INSERT INTO `images` VALUES (14, '2024-02-26 03:37:10.998', '2024-02-26 03:37:10.998', NULL, '/public/uploads/apple.jpg', 14);
INSERT INTO `images` VALUES (15, '2024-02-26 03:37:11.003', '2024-02-26 03:37:11.003', NULL, '/public/uploads/apple.jpg', 15);
INSERT INTO `images` VALUES (16, '2024-02-26 03:37:11.004', '2024-02-26 03:37:11.004', NULL, '/public/uploads/apple.jpg', 16);
INSERT INTO `images` VALUES (17, '2024-02-26 03:37:11.005', '2024-02-26 03:37:11.005', NULL, '/public/uploads/apple.jpg', 17);
INSERT INTO `images` VALUES (18, '2024-02-26 03:37:11.006', '2024-02-26 03:37:11.006', NULL, '/public/uploads/apple.jpg', 18);
INSERT INTO `images` VALUES (19, '2024-02-26 03:37:11.008', '2024-02-26 03:37:11.008', NULL, '/public/uploads/apple.jpg', 19);
INSERT INTO `images` VALUES (20, '2024-02-26 03:37:11.009', '2024-02-26 03:37:11.009', NULL, '/public/uploads/apple.jpg', 20);

-- ----------------------------
-- Table structure for menu_items
-- ----------------------------
DROP TABLE IF EXISTS `menu_items`;
CREATE TABLE `menu_items`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单项ID，主键',
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `ord` bigint(20) NULL DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `class` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `menu_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_menu_items_children`(`parent_id`) USING BTREE,
  INDEX `fk_menus_items`(`menu_id`) USING BTREE,
  CONSTRAINT `fk_menu_items_children` FOREIGN KEY (`parent_id`) REFERENCES `menu_items` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_menus_items` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_items
-- ----------------------------
INSERT INTO `menu_items` VALUES (1, '2024-02-26 03:37:11.012', '2024-02-26 03:37:11.012', NULL, 'Home', '/', 1, NULL, '', 1);
INSERT INTO `menu_items` VALUES (2, '2024-02-26 03:37:11.014', '2024-02-26 03:37:11.014', NULL, 'About', '/pages/2-', 2, NULL, '', 1);
INSERT INTO `menu_items` VALUES (3, '2024-02-26 03:37:11.015', '2024-02-26 03:37:11.015', NULL, 'Lorem Ipsum 1', '#', 1, NULL, '', 2);
INSERT INTO `menu_items` VALUES (4, '2024-02-26 03:37:11.015', '2024-02-26 03:37:11.015', NULL, 'Subitem 1', '/', 1, 3, '', 2);
INSERT INTO `menu_items` VALUES (5, '2024-02-26 03:37:11.017', '2024-02-26 03:37:11.017', NULL, 'Lorem Ipsum 2', '#', 2, NULL, '', 2);
INSERT INTO `menu_items` VALUES (6, '2024-02-26 03:37:11.017', '2024-02-26 03:37:11.017', NULL, 'Subitem 2', '/', 1, 5, '', 2);
INSERT INTO `menu_items` VALUES (7, '2024-02-26 03:37:11.018', '2024-02-26 03:37:11.018', NULL, 'Lorem Ipsum 3', '#', 3, NULL, '', 2);
INSERT INTO `menu_items` VALUES (8, '2024-02-26 03:37:11.018', '2024-02-26 03:37:11.018', NULL, 'Subitem 3', '/', 1, 7, '', 2);
INSERT INTO `menu_items` VALUES (9, '2024-02-26 03:37:11.020', '2024-02-26 03:37:11.020', NULL, 'Lorem Ipsum 4', '#', 4, NULL, '', 2);
INSERT INTO `menu_items` VALUES (10, '2024-02-26 03:37:11.020', '2024-02-26 03:37:11.020', NULL, 'Subitem 4', '/', 1, 9, '', 2);

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '菜单ID，主键',
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `code` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES (1, '2024-02-26 03:37:11.010', '2024-02-26 03:37:11.010', NULL, 'main', 'Main menu');
INSERT INTO `menus` VALUES (2, '2024-02-26 03:37:11.011', '2024-02-26 03:37:11.011', NULL, 'footer', 'Footer menu');

-- ----------------------------
-- Table structure for order_products
-- ----------------------------
DROP TABLE IF EXISTS `order_products`;
CREATE TABLE `order_products`  (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单ID，主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间，软删除标志',
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名字',
  `middle_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '中间名',
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓氏',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '评论',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pages
-- ----------------------------
DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '页面ID，主键',
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `slug` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `published` tinyint(1) NULL DEFAULT NULL,
  `meta_keywords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `meta_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pages
-- ----------------------------
INSERT INTO `pages` VALUES (1, '2023-12-11 18:51:52.275', '2023-12-11 18:51:52.275', NULL, 'Welcome To ginshop Skeleton Project', '\n			<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\n			<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>\n			', '', 0, '', '');
INSERT INTO `pages` VALUES (2, '2023-12-11 18:51:52.278', '2023-12-11 18:51:52.278', NULL, 'About ginshop', 'ginshop is a skeleton project for basic e-shop web-sites. It demonstrates user authentication, 3 user roles: admin, manager & customer, product cart & checkout, email notifications, user dashboard for all roles, some ui animations via Animate On Scroll library, bootstrap 4 template, home page carousel and may be something more...', '', 1, '', '');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '产品ID，主键',
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `meta_keywords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `meta_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `category_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `published` tinyint(1) NULL DEFAULT NULL,
  `slug` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `default_image_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `recommended` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_products_category`(`category_id`) USING BTREE,
  CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, '2024-02-26 03:37:10.978', '2024-02-26 03:37:10.978', NULL, 'Demo product 0', 'Product description goes here', '', '', 1, 1, 'demo-product-0', 0, 1);
INSERT INTO `products` VALUES (2, '2024-02-26 03:37:10.981', '2024-02-26 03:37:10.981', NULL, 'Demo product 1', 'Product description goes here', '', '', 1, 1, 'demo-product-1', 0, 1);
INSERT INTO `products` VALUES (3, '2024-02-26 03:37:10.984', '2024-02-26 03:37:10.984', NULL, 'Demo product 2', 'Product description goes here', '', '', 1, 1, 'demo-product-2', 0, 1);
INSERT INTO `products` VALUES (4, '2024-02-26 03:37:10.985', '2024-02-26 03:37:10.985', NULL, 'Demo product 3', 'Product description goes here', '', '', 1, 1, 'demo-product-3', 0, 1);
INSERT INTO `products` VALUES (5, '2024-02-26 03:37:10.986', '2024-02-26 03:37:10.986', NULL, 'Demo product 4', 'Product description goes here', '', '', 1, 1, 'demo-product-4', 0, 1);
INSERT INTO `products` VALUES (6, '2024-02-26 03:37:10.988', '2024-02-26 03:37:10.988', NULL, 'Demo product 5', 'Product description goes here', '', '', 1, 1, 'demo-product-5', 0, 1);
INSERT INTO `products` VALUES (7, '2024-02-26 03:37:10.989', '2024-02-26 03:37:10.989', NULL, 'Demo product 6', 'Product description goes here', '', '', 1, 1, 'demo-product-6', 0, 1);
INSERT INTO `products` VALUES (8, '2024-02-26 03:37:10.990', '2024-02-26 03:37:10.990', NULL, 'Demo product 7', 'Product description goes here', '', '', 1, 1, 'demo-product-7', 0, 1);
INSERT INTO `products` VALUES (9, '2024-02-26 03:37:10.990', '2024-02-26 03:37:10.990', NULL, 'Demo product 8', 'Product description goes here', '', '', 1, 1, 'demo-product-8', 0, 1);
INSERT INTO `products` VALUES (10, '2024-02-26 03:37:10.992', '2024-02-26 03:37:10.992', NULL, 'Demo product 9', 'Product description goes here', '', '', 1, 1, 'demo-product-9', 0, 1);
INSERT INTO `products` VALUES (11, '2024-02-26 03:37:10.994', '2024-02-26 03:37:10.994', NULL, 'Demo product 10', 'Product description goes here', '', '', 1, 1, 'demo-product-10', 0, 1);
INSERT INTO `products` VALUES (12, '2024-02-26 03:37:10.994', '2024-02-26 03:37:10.994', NULL, 'Demo product 11', 'Product description goes here', '', '', 1, 1, 'demo-product-11', 0, 1);
INSERT INTO `products` VALUES (13, '2024-02-26 03:37:10.996', '2024-02-26 03:37:10.996', NULL, 'Demo product 12', 'Product description goes here', '', '', 1, 1, 'demo-product-12', 0, 1);
INSERT INTO `products` VALUES (14, '2024-02-26 03:37:10.997', '2024-02-26 03:37:10.997', NULL, 'Demo product 13', 'Product description goes here', '', '', 1, 1, 'demo-product-13', 0, 1);
INSERT INTO `products` VALUES (15, '2024-02-26 03:37:11.002', '2024-02-26 03:37:11.002', NULL, 'Demo product 14', 'Product description goes here', '', '', 1, 1, 'demo-product-14', 0, 1);
INSERT INTO `products` VALUES (16, '2024-02-26 03:37:11.004', '2024-02-26 03:37:11.004', NULL, 'Demo product 15', 'Product description goes here', '', '', 1, 1, 'demo-product-15', 0, 1);
INSERT INTO `products` VALUES (17, '2024-02-26 03:37:11.005', '2024-02-26 03:37:11.005', NULL, 'Demo product 16', 'Product description goes here', '', '', 1, 1, 'demo-product-16', 0, 1);
INSERT INTO `products` VALUES (18, '2024-02-26 03:37:11.006', '2024-02-26 03:37:11.006', NULL, 'Demo product 17', 'Product description goes here', '', '', 1, 1, 'demo-product-17', 0, 1);
INSERT INTO `products` VALUES (19, '2024-02-26 03:37:11.008', '2024-02-26 03:37:11.008', NULL, 'Demo product 18', 'Product description goes here', '', '', 1, 1, 'demo-product-18', 0, 1);
INSERT INTO `products` VALUES (20, '2024-02-26 03:37:11.009', '2024-02-26 03:37:11.009', NULL, 'Demo product 19', 'Product description goes here', '', '', 1, 1, 'demo-product-19', 0, 1);

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '设置ID，主键',
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `code` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES (1, '2023-12-11 18:51:52.000', '2023-12-11 18:51:52.000', NULL, 'tel_1', 'Contact phone #1', '+1 300 33-33-33');
INSERT INTO `settings` VALUES (2, '2023-12-11 18:51:52.000', '2023-12-11 18:51:52.000', NULL, 'tel_2', 'Contact phone #2', '+1 300 43-33-33');
INSERT INTO `settings` VALUES (3, '2023-12-11 18:51:52.000', '2023-12-11 18:51:52.000', NULL, 'tel_3', 'Contact phone #3', '+1 300 53-33-33');
INSERT INTO `settings` VALUES (4, '2023-12-11 18:51:52.000', '2023-12-11 18:51:52.000', NULL, 'email', 'Contact email', 'email@example.org');
INSERT INTO `settings` VALUES (5, '2023-12-11 18:51:52.000', '2023-12-11 18:51:52.000', NULL, 'order_email', 'Email for order notifications', 'order@example.org');
INSERT INTO `settings` VALUES (6, '2023-12-11 18:51:52.000', '2023-12-11 18:51:52.000', NULL, 'title_suffix', 'Meta Title suffix', 'Awesome business skeletons');
INSERT INTO `settings` VALUES (7, '2023-12-11 18:51:52.000', '2023-12-11 18:51:52.000', NULL, 'home_id', 'Home Page ID', '1');
INSERT INTO `settings` VALUES (8, '2023-12-11 18:51:52.000', '2023-12-11 18:51:52.000', NULL, 'about_id', 'About Page ID', '2');

-- ----------------------------
-- Table structure for slides
-- ----------------------------
DROP TABLE IF EXISTS `slides`;
CREATE TABLE `slides`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '幻灯片ID，主键',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  `updated_at` datetime(0) NOT NULL COMMENT '更新时间',
  `deleted_at` datetime(0) NULL DEFAULT NULL COMMENT '删除时间，软删除标志',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `navigation_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '导航URL',
  `file_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件URL',
  `ord` int(11) NULL DEFAULT NULL COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of slides
-- ----------------------------
INSERT INTO `slides` VALUES (1, '2023-12-11 18:51:52', '2023-12-11 18:51:52', NULL, 'Demo slide Title', '', '/', '/public/uploads/tables.jpg', 0);
INSERT INTO `slides` VALUES (2, '2023-12-11 18:51:52', '2023-12-11 18:51:52', NULL, 'Demo slide Title 2', '', '/', '/public/uploads/window_sills.jpg', 0);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID，主键',
  `created_at` datetime(3) NULL DEFAULT NULL,
  `updated_at` datetime(3) NULL DEFAULT NULL,
  `deleted_at` datetime(3) NULL DEFAULT NULL,
  `email` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `first_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `middle_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `last_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `password` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `role` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (5, '2024-02-26 03:37:28.327', '2024-02-26 03:37:28.327', NULL, 'admin@admin.com', 'Admin', 'A.', 'Admin', '$2a$10$sYxDw.k1IaRHBGNKGURmWu4NPcpxEpnMax06KislT/.etVXoVEqOu', 'admin');
INSERT INTO `users` VALUES (6, '2024-02-26 03:37:28.374', '2024-02-26 03:37:28.374', NULL, 'manager@manager.com', 'Manager', 'M.', 'Manager', '$2a$10$U.pCRakwZU6E0ve4zff4O.jjlSh3y4liz3QP4Sw6GdlV37yQMhASu', 'manager');
INSERT INTO `users` VALUES (7, '2024-02-26 03:37:28.420', '2024-02-26 03:37:28.420', NULL, 'customer@customer.com', 'Customer', 'C.', 'Customer', '$2a$10$0cUf8sgXqowfZemvtblBDu.XA1tc20gn/oER7ibPRyfcueStjDDRm', 'customer');

SET FOREIGN_KEY_CHECKS = 1;

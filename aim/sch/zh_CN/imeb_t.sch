/* 
================================================================================
檔案代號:imeb_t
檔案名稱:料件特徵群組單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imeb_t
(
imebent       number(5)      ,/* 企業編號 */
imeb001       varchar2(40)      ,/* 特徵群組代碼 */
imeb002       number(10,0)      ,/* 項次 */
imeb003       varchar2(10)      ,/* 歸屬層級 */
imeb004       varchar2(10)      ,/* 類型 */
imeb005       varchar2(10)      ,/* 賦值方式 */
imeb006       varchar2(10)      ,/* 屬性類型 */
imeb007       number(5,0)      ,/* 碼長 */
imeb008       number(5,0)      ,/* 小數位數 */
imeb009       varchar2(30)      ,/* 預設值 */
imeb010       varchar2(30)      ,/* 最小限制 */
imeb011       varchar2(30)      ,/* 最大限制 */
imeb012       varchar2(1)      ,/* 二維輸入 */
imebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imeb_t add constraint imeb_pk primary key (imebent,imeb001,imeb002) enable validate;

create  index imeb_01 on imeb_t (imebent,imeb001,imeb004);
create unique index imeb_pk on imeb_t (imebent,imeb001,imeb002);

grant select on imeb_t to tiptop;
grant update on imeb_t to tiptop;
grant delete on imeb_t to tiptop;
grant insert on imeb_t to tiptop;

exit;

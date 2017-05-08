/* 
================================================================================
檔案代號:imda_t
檔案名稱:料件引入營運據點產品分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imda_t
(
imdaent       number(5)      ,/* 企業編號 */
imdastus       varchar2(10)      ,/* 狀態碼 */
imda001       varchar2(10)      ,/* 營運據點 */
imda002       varchar2(10)      ,/* 產品分類 */
imda003       varchar2(10)      ,/* 引入方式 */
imda004       varchar2(10)      ,/* 補給策略 */
imda005       varchar2(1)      ,/* BOM引入 */
imdaownid       varchar2(20)      ,/* 資料所有者 */
imdaowndp       varchar2(10)      ,/* 資料所屬部門 */
imdacrtid       varchar2(20)      ,/* 資料建立者 */
imdacrtdt       timestamp(0)      ,/* 資料創建日 */
imdacrtdp       varchar2(10)      ,/* 資料建立部門 */
imdamodid       varchar2(20)      ,/* 資料修改者 */
imdamoddt       timestamp(0)      ,/* 最近修改日 */
imdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imda_t add constraint imda_pk primary key (imdaent,imda001,imda002) enable validate;

create  index imda_01 on imda_t (imda001,imda002);
create unique index imda_pk on imda_t (imdaent,imda001,imda002);

grant select on imda_t to tiptop;
grant update on imda_t to tiptop;
grant delete on imda_t to tiptop;
grant insert on imda_t to tiptop;

exit;

/* 
================================================================================
檔案代號:imch_t
檔案名稱:料件據點財務分群檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imch_t
(
imchent       number(5)      ,/* 企業編號 */
imchsite       varchar2(10)      ,/* 法人營運據點 */
imch011       varchar2(10)      ,/* 財務分群碼 */
imch012       varchar2(24)      ,/* 採購入庫借方會科 */
imch013       varchar2(40)      ,/* 成本料號 */
imch014       varchar2(10)      ,/* 成本單位 */
imch015       varchar2(10)      ,/* 成本計價方式 */
imchownid       varchar2(20)      ,/* 資料所有者 */
imchowndp       varchar2(10)      ,/* 資料所屬部門 */
imchcrtid       varchar2(20)      ,/* 資料建立者 */
imchcrtdp       varchar2(10)      ,/* 資料建立部門 */
imchcrtdt       timestamp(0)      ,/* 資料創建日 */
imchmodid       varchar2(20)      ,/* 資料修改者 */
imchmoddt       timestamp(0)      ,/* 最近修改日 */
imchstus       varchar2(10)      ,/* 狀態碼 */
imchud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imchud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imchud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imchud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imchud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imchud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imchud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imchud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imchud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imchud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imchud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imchud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imchud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imchud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imchud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imchud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imchud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imchud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imchud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imchud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imchud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imchud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imchud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imchud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imchud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imchud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imchud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imchud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imchud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imchud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imch_t add constraint imch_pk primary key (imchent,imchsite,imch011) enable validate;

create unique index imch_pk on imch_t (imchent,imchsite,imch011);

grant select on imch_t to tiptop;
grant update on imch_t to tiptop;
grant delete on imch_t to tiptop;
grant insert on imch_t to tiptop;

exit;

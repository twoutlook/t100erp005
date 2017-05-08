/* 
================================================================================
檔案代號:xcfk_t
檔案名稱:存貨貨齡數量期初開帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcfk_t
(
xcfkent       number(5)      ,/* 企業編號 */
xcfkcomp       varchar2(10)      ,/* 法人組織 */
xcfksite       varchar2(10)      ,/* 營運組織 */
xcfk001       varchar2(40)      ,/* 料件 */
xcfk002       varchar2(256)      ,/* 特性 */
xcfk003       varchar2(10)      ,/* 倉庫 */
xcfk004       varchar2(10)      ,/* 儲位 */
xcfk005       varchar2(30)      ,/* 批號 */
xcfk006       date      ,/* 異動日期 */
xcfk007       varchar2(10)      ,/* 成本單位 */
xcfk008       number(20,6)      ,/* 數量 */
xcfkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcfkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcfkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcfkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcfkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcfkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcfkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcfkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcfkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcfkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcfkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcfkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcfkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcfkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcfkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcfkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcfkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcfkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcfkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcfkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcfkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcfkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcfkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcfkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcfkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcfkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcfkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcfkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcfkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcfkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcfk_t add constraint xcfk_pk primary key (xcfkent,xcfksite,xcfk001,xcfk002,xcfk003,xcfk004,xcfk005,xcfk006) enable validate;

create unique index xcfk_pk on xcfk_t (xcfkent,xcfksite,xcfk001,xcfk002,xcfk003,xcfk004,xcfk005,xcfk006);

grant select on xcfk_t to tiptop;
grant update on xcfk_t to tiptop;
grant delete on xcfk_t to tiptop;
grant insert on xcfk_t to tiptop;

exit;

/* 
================================================================================
檔案代號:prds_t
檔案名稱:促銷規則條件資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prds_t
(
prdsent       number(5)      ,/* 企業編號 */
prdsunit       varchar2(10)      ,/* 應用組織 */
prdssite       varchar2(10)      ,/* 營運據點 */
prds000       varchar2(10)      ,/* 條件分類 */
prds001       varchar2(20)      ,/* 規則編號 */
prds002       number(10,0)      ,/* 組別 */
prds003       varchar2(10)      ,/* 條件類型 */
prds004       varchar2(10)      ,/* 參與方式 */
prds005       number(20,6)      ,/* 金額/數量 */
prds006       number(10,0)      ,/* 基數 */
prds007       number(10,0)      ,/* 幅度 */
prds008       varchar2(10)      ,/* 商品條件 */
prds009       varchar2(10)      ,/* 促銷方式 */
prds010       varchar2(1)      ,/* 常規搭贈 */
prds011       number(20,6)      ,/* 承擔比例 */
prds012       number(20,6)      ,/* 目標數量 */
prds013       number(20,6)      ,/* 目標金額 */
prdsstus       varchar2(10)      ,/* 有效否 */
prdsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prds_t add constraint prds_pk primary key (prdsent,prds001,prds002) enable validate;

create unique index prds_pk on prds_t (prdsent,prds001,prds002);

grant select on prds_t to tiptop;
grant update on prds_t to tiptop;
grant delete on prds_t to tiptop;
grant insert on prds_t to tiptop;

exit;

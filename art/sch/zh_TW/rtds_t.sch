/* 
================================================================================
檔案代號:rtds_t
檔案名稱:自有商品引進-商品明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtds_t
(
rtdsent       number(5)      ,/* 企業編號 */
rtdsdocno       varchar2(20)      ,/* 單據編號 */
rtdsseq       number(10,0)      ,/* 項次 */
rtds001       varchar2(40)      ,/* 商品編號 */
rtds002       varchar2(40)      ,/* 商品條碼 */
rtds003       varchar2(10)      ,/* 銷項稅目 */
rtds004       number(5,2)      ,/* No use */
rtds005       varchar2(80)      ,/* 產地 */
rtds006       varchar2(10)      ,/* 採購單位 */
rtds007       varchar2(10)      ,/* 包裝單位 */
rtds008       number(15,3)      ,/* 件裝數 */
rtds009       varchar2(10)      ,/* 配送方式 */
rtds010       number(20,6)      ,/* 售價 */
rtds011       number(20,6)      ,/* 會員價1 */
rtds012       number(20,6)      ,/* 會員價2 */
rtds013       number(20,6)      ,/* 會員價3 */
rtds014       varchar2(10)      ,/* 銷售單位 */
rtdsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdsud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtds015       varchar2(1)      /* 手工折價否 */
);
alter table rtds_t add constraint rtds_pk primary key (rtdsent,rtdsdocno,rtdsseq) enable validate;

create unique index rtds_pk on rtds_t (rtdsent,rtdsdocno,rtdsseq);

grant select on rtds_t to tiptop;
grant update on rtds_t to tiptop;
grant delete on rtds_t to tiptop;
grant insert on rtds_t to tiptop;

exit;

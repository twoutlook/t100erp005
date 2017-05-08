/* 
================================================================================
檔案代號:rtdw_t
檔案名稱:自營新商品引進-門店明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdw_t
(
rtdwent       number(5)      ,/* 企業編號 */
rtdwdocno       varchar2(20)      ,/* 單據編號 */
rtdw001       varchar2(10)      ,/* 門店編號 */
rtdwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdwud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtdw002       varchar2(10)      /* 庫位編號 */
);
alter table rtdw_t add constraint rtdw_pk primary key (rtdwent,rtdwdocno,rtdw001) enable validate;

create unique index rtdw_pk on rtdw_t (rtdwent,rtdwdocno,rtdw001);

grant select on rtdw_t to tiptop;
grant update on rtdw_t to tiptop;
grant delete on rtdw_t to tiptop;
grant insert on rtdw_t to tiptop;

exit;

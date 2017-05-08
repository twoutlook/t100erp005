/* 
================================================================================
檔案代號:rtah_t
檔案名稱:品類策略異動申請-門店明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtah_t
(
rtahent       number(5)      ,/* 企業編號 */
rtahdocno       varchar2(20)      ,/* 單據編號 */
rtah001       varchar2(10)      ,/* 策略編號 */
rtah002       varchar2(10)      ,/* 門店編號 */
rtahacti       varchar2(1)      ,/* 資料有效碼 */
rtahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtah_t add constraint rtah_pk primary key (rtahent,rtahdocno,rtah002) enable validate;

create unique index rtah_pk on rtah_t (rtahent,rtahdocno,rtah002);

grant select on rtah_t to tiptop;
grant update on rtah_t to tiptop;
grant delete on rtah_t to tiptop;
grant insert on rtah_t to tiptop;

exit;

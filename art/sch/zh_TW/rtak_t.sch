/* 
================================================================================
檔案代號:rtak_t
檔案名稱:店群性質明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtak_t
(
rtakent       number(5)      ,/* 企業編號 */
rtak001       varchar2(10)      ,/* 店群編號 */
rtak002       varchar2(10)      ,/* 店群性質 */
rtak003       varchar2(10)      ,/* 性質選擇 */
rtakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtak_t add constraint rtak_pk primary key (rtakent,rtak001,rtak002) enable validate;

create unique index rtak_pk on rtak_t (rtakent,rtak001,rtak002);

grant select on rtak_t to tiptop;
grant update on rtak_t to tiptop;
grant delete on rtak_t to tiptop;
grant insert on rtak_t to tiptop;

exit;

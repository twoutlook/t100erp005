/* 
================================================================================
檔案代號:imal_t
檔案名稱:料件標籤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imal_t
(
imalent       number(5)      ,/* 企業編號 */
imal001       varchar2(40)      ,/* 料件編號 */
imal002       varchar2(10)      ,/* 產品標籤 */
imalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imalud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imal_t add constraint imal_pk primary key (imalent,imal001,imal002) enable validate;

create unique index imal_pk on imal_t (imalent,imal001,imal002);

grant select on imal_t to tiptop;
grant update on imal_t to tiptop;
grant delete on imal_t to tiptop;
grant insert on imal_t to tiptop;

exit;

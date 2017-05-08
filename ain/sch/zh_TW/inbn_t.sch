/* 
================================================================================
檔案代號:inbn_t
檔案名稱:裝箱單單身箱明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inbn_t
(
inbnent       number(5)      ,/* 企業編號 */
inbnsite       varchar2(10)      ,/* 營運據點 */
inbnunit       varchar2(10)      ,/* 物流中心 */
inbndocno       varchar2(20)      ,/* 單據編號 */
inbn001       varchar2(10)      ,/* 箱號 */
inbn002       varchar2(10)      ,/* 箱狀態 */
inbnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inbn_t add constraint inbn_pk primary key (inbnent,inbndocno,inbn001) enable validate;

create unique index inbn_pk on inbn_t (inbnent,inbndocno,inbn001);

grant select on inbn_t to tiptop;
grant update on inbn_t to tiptop;
grant delete on inbn_t to tiptop;
grant insert on inbn_t to tiptop;

exit;

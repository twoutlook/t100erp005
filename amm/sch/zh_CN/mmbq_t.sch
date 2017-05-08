/* 
================================================================================
檔案代號:mmbq_t
檔案名稱:卡活動除外規則申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmbq_t
(
mmbqent       number(5)      ,/* 企業編號 */
mmbqsite       varchar2(10)      ,/* 營運據點 */
mmbqunit       varchar2(10)      ,/* 應用組織 */
mmbqdocno       varchar2(20)      ,/* 單據編號 */
mmbq001       varchar2(30)      ,/* 活動規則編號 */
mmbq002       varchar2(10)      ,/* 卡種編號 */
mmbq003       varchar2(10)      ,/* 規則類型 */
mmbq004       varchar2(40)      ,/* 規則編碼 */
mmbqacti       varchar2(1)      ,/* 有效 */
mmbqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbq_t add constraint mmbq_pk primary key (mmbqent,mmbqdocno,mmbq003,mmbq004) enable validate;

create unique index mmbq_pk on mmbq_t (mmbqent,mmbqdocno,mmbq003,mmbq004);

grant select on mmbq_t to tiptop;
grant update on mmbq_t to tiptop;
grant delete on mmbq_t to tiptop;
grant insert on mmbq_t to tiptop;

exit;

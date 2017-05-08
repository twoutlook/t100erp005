/* 
================================================================================
檔案代號:stin_t
檔案名稱:招商租賃合約申請合約日核算單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stin_t
(
stinent       number(5)      ,/* 企業編號 */
stinsite       varchar2(10)      ,/* 營運組織 */
stinunit       varchar2(10)      ,/* 制定組織 */
stindocno       varchar2(20)      ,/* 單據編號 */
stinseq       number(10,0)      ,/* 項次 */
stin001       varchar2(20)      ,/* 合約編號 */
stin002       date      ,/* 分攤日期 */
stin003       varchar2(10)      ,/* 優惠類型 */
stin004       varchar2(10)      ,/* 資料類型 */
stin005       varchar2(10)      ,/* 費用編號 */
stin006       number(20,6)      ,/* 费用金额 */
stin007       varchar2(20)      ,/* 參考單號 */
stin008       varchar2(10)      ,/* 參考單號版本 */
stinud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stinud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stinud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stinud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stinud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stinud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stinud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stinud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stinud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stinud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stinud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stinud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stinud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stinud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stinud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stinud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stinud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stinud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stinud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stinud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stinud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stinud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stinud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stinud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stinud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stinud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stinud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stinud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stinud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stinud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stin009       varchar2(10)      ,/* 合約版本 */
stin010       number(10,0)      /* 合約費用項次 */
);
alter table stin_t add constraint stin_pk primary key (stinent,stindocno,stinseq) enable validate;

create unique index stin_pk on stin_t (stinent,stindocno,stinseq);

grant select on stin_t to tiptop;
grant update on stin_t to tiptop;
grant delete on stin_t to tiptop;
grant insert on stin_t to tiptop;

exit;

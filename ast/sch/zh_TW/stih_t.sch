/* 
================================================================================
檔案代號:stih_t
檔案名稱:招商租賃合約申請優惠費用單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stih_t
(
stihent       number(5)      ,/* 企業編號 */
stihsite       varchar2(10)      ,/* 營運組織 */
stihunit       varchar2(10)      ,/* 制定組織 */
stihdocno       varchar2(20)      ,/* 單據編號 */
stihseq       number(10,0)      ,/* 項次 */
stih001       varchar2(20)      ,/* 合約編號 */
stih002       varchar2(10)      ,/* 費用編號 */
stih003       varchar2(20)      ,/* 優惠單號 */
stih004       date      ,/* 開始日期 */
stih005       date      ,/* 截止日期 */
stih006       number(20,6)      ,/* 費用金額 */
stih007       varchar2(10)      ,/* 合約版本 */
stihud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stihud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stihud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stihud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stihud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stihud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stihud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stihud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stihud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stihud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stihud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stihud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stihud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stihud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stihud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stihud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stihud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stihud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stihud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stihud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stihud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stihud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stihud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stihud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stihud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stihud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stihud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stihud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stihud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stihud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stih008       varchar2(10)      /* 優惠類型 */
);
alter table stih_t add constraint stih_pk primary key (stihent,stihdocno,stihseq) enable validate;

create unique index stih_pk on stih_t (stihent,stihdocno,stihseq);

grant select on stih_t to tiptop;
grant update on stih_t to tiptop;
grant delete on stih_t to tiptop;
grant insert on stih_t to tiptop;

exit;

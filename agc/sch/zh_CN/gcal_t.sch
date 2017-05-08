/* 
================================================================================
檔案代號:gcal_t
檔案名稱:券發行單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gcal_t
(
gcalent       number(5)      ,/* 企業編號 */
gcalsite       varchar2(10)      ,/* 營運據點 */
gcalunit       varchar2(10)      ,/* 應用組織 */
gcaldocno       varchar2(20)      ,/* 單據編號 */
gcalseq       number(10,0)      ,/* 項次 */
gcal001       varchar2(10)      ,/* 券種編號 */
gcal002       number(5,0)      ,/* 券號總碼長 */
gcal003       number(5,0)      ,/* 券號固定代碼長度 */
gcal004       varchar2(30)      ,/* 券號固定代碼 */
gcal005       number(5,0)      ,/* 券號流水碼長度 */
gcal006       varchar2(1)      ,/* 產生券號明細 */
gcal007       number(10,0)      ,/* 發行張數 */
gcal008       varchar2(40)      ,/* 提貨券商品編號 */
gcal009       varchar2(30)      ,/* 開始券號 */
gcal010       varchar2(30)      ,/* 結束券號 */
gcal011       varchar2(10)      ,/* 空白券庫區 */
gcal012       varchar2(10)      ,/* 發行券庫區 */
gcal013       varchar2(10)      ,/* 券面額編號 */
gcal014       number(20,6)      ,/* 券單位金額 */
gcalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcalud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcal_t add constraint gcal_pk primary key (gcalent,gcaldocno,gcalseq) enable validate;

create unique index gcal_pk on gcal_t (gcalent,gcaldocno,gcalseq);

grant select on gcal_t to tiptop;
grant update on gcal_t to tiptop;
grant delete on gcal_t to tiptop;
grant insert on gcal_t to tiptop;

exit;

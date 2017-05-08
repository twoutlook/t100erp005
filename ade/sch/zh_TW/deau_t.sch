/* 
================================================================================
檔案代號:deau_t
檔案名稱:導入對方保全對賬明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table deau_t
(
deauent       number(5)      ,/* 企業編號 */
deausite       varchar2(10)      ,/* 營運據點 */
deauunit       varchar2(10)      ,/* 應用組織 */
deaudocno       varchar2(20)      ,/* 單據編號 */
deaudocdt       date      ,/* 營業日期 */
deauseq       number(10,0)      ,/* 項次 */
deau001       varchar2(10)      ,/* 款別分類 */
deau002       varchar2(10)      ,/* 款別編號 */
deau003       varchar2(10)      ,/* 卡券種編號 */
deau004       varchar2(10)      ,/* 券面額編號 */
deau005       varchar2(10)      ,/* 幣別 */
deau006       number(20,6)      ,/* 代收數量 */
deau007       number(20,6)      ,/* 代收金額 */
deau008       varchar2(20)      ,/* 支票號碼 */
deau009       varchar2(80)      ,/* 備註 */
deauud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deauud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deauud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deauud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deauud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deauud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deauud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deauud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deauud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deauud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deauud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deauud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deauud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deauud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deauud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deauud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deauud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deauud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deauud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deauud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deauud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deauud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deauud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deauud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deauud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deauud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deauud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deauud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deauud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deauud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deau_t add constraint deau_pk primary key (deauent,deaudocno,deauseq) enable validate;

create unique index deau_pk on deau_t (deauent,deaudocno,deauseq);

grant select on deau_t to tiptop;
grant update on deau_t to tiptop;
grant delete on deau_t to tiptop;
grant insert on deau_t to tiptop;

exit;

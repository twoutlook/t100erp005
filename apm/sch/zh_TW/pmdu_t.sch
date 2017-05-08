/* 
================================================================================
檔案代號:pmdu_t
檔案名稱:收貨/驗退/入庫/倉退單多庫儲批收貨明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdu_t
(
pmduent       number(5)      ,/* 企業編號 */
pmdusite       varchar2(10)      ,/* 營運據點 */
pmdudocno       varchar2(20)      ,/* 單據編號 */
pmduseq       number(10,0)      ,/* 項次 */
pmduseq1       number(10,0)      ,/* 項序 */
pmdu001       varchar2(40)      ,/* 料件編號 */
pmdu002       varchar2(256)      ,/* 產品特徵 */
pmdu003       varchar2(10)      ,/* 作業編號 */
pmdu004       varchar2(10)      ,/* 作業序 */
pmdu005       varchar2(30)      ,/* 庫存管理特徵 */
pmdu006       varchar2(10)      ,/* 庫位 */
pmdu007       varchar2(10)      ,/* 儲位 */
pmdu008       varchar2(30)      ,/* 批號 */
pmdu009       varchar2(10)      ,/* 單位 */
pmdu010       number(20,6)      ,/* 數量 */
pmdu011       varchar2(10)      ,/* 參考單位 */
pmdu012       number(20,6)      ,/* 參考數量 */
pmdu013       number(20,6)      ,/* 允收數量 */
pmdu014       number(20,6)      ,/* 已入庫量 */
pmdu015       number(20,6)      ,/* 已驗退量 */
pmdu016       varchar2(255)      ,/* 存貨備註 */
pmdu017       date      ,/* 有效日期 */
pmduud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmduud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmduud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmduud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmduud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmduud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmduud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmduud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmduud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmduud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmduud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmduud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmduud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmduud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmduud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmduud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmduud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmduud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmduud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmduud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmduud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmduud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmduud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmduud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmduud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmduud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmduud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmduud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmduud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmduud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmdu200       varchar2(10)      ,/* 包裝單位 */
pmdu201       number(20,6)      ,/* 包裝數量 */
pmdu202       date      /* 製造日期 */
);
alter table pmdu_t add constraint pmdu_pk primary key (pmduent,pmdudocno,pmduseq,pmduseq1) enable validate;

create unique index pmdu_pk on pmdu_t (pmduent,pmdudocno,pmduseq,pmduseq1);

grant select on pmdu_t to tiptop;
grant update on pmdu_t to tiptop;
grant delete on pmdu_t to tiptop;
grant insert on pmdu_t to tiptop;

exit;

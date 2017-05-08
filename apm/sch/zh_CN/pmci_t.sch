/* 
================================================================================
檔案代號:pmci_t
檔案名稱:供應商評核定性評分明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmci_t
(
pmcient       number(5)      ,/* 企業編號 */
pmcidocno       varchar2(20)      ,/* 單據編號 */
pmciseq       number(10,0)      ,/* 項次 */
pmci001       varchar2(10)      ,/* 供應商編號 */
pmci002       varchar2(10)      ,/* 評核項目 */
pmci003       number(5,0)      ,/* 得分 */
pmciud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmciud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmciud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmciud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmciud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmciud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmciud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmciud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmciud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmciud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmciud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmciud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmciud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmciud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmciud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmciud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmciud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmciud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmciud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmciud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmciud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmciud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmciud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmciud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmciud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmciud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmciud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmciud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmciud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmciud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmci_t add constraint pmci_pk primary key (pmcient,pmcidocno,pmciseq) enable validate;

create unique index pmci_pk on pmci_t (pmcient,pmcidocno,pmciseq);

grant select on pmci_t to tiptop;
grant update on pmci_t to tiptop;
grant delete on pmci_t to tiptop;
grant insert on pmci_t to tiptop;

exit;

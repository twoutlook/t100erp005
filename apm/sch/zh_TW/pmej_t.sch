/* 
================================================================================
檔案代號:pmej_t
檔案名稱:採購變更多交期匯總檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmej_t
(
pmejent       number(5)      ,/* 企業編號 */
pmejsite       varchar2(10)      ,/* 營運據點 */
pmejdocno       varchar2(20)      ,/* 採購變更單號 */
pmejseq       number(10,0)      ,/* 採購項次 */
pmej001       number(10,0)      ,/* 分批序 */
pmej002       number(20,6)      ,/* 分批數量 */
pmej003       date      ,/* 交貨日期 */
pmej004       date      ,/* 到廠日期 */
pmej005       date      ,/* 到庫日期 */
pmej006       varchar2(10)      ,/* 收貨時段 */
pmej007       varchar2(1)      ,/* MRP凍結否 */
pmej008       varchar2(10)      ,/* 交期類型 */
pmej900       number(10,0)      ,/* 變更序 */
pmej901       varchar2(1)      ,/* 變更類型 */
pmejud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmejud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmejud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmejud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmejud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmejud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmejud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmejud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmejud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmejud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmejud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmejud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmejud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmejud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmejud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmejud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmejud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmejud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmejud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmejud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmejud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmejud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmejud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmejud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmejud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmejud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmejud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmejud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmejud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmejud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmej201       varchar2(10)      ,/* 分批包裝單位 */
pmej202       number(20,6)      /* 分批包裝數量 */
);
alter table pmej_t add constraint pmej_pk primary key (pmejent,pmejdocno,pmejseq,pmej001,pmej900) enable validate;

create unique index pmej_pk on pmej_t (pmejent,pmejdocno,pmejseq,pmej001,pmej900);

grant select on pmej_t to tiptop;
grant update on pmej_t to tiptop;
grant delete on pmej_t to tiptop;
grant insert on pmej_t to tiptop;

exit;

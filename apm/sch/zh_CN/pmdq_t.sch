/* 
================================================================================
檔案代號:pmdq_t
檔案名稱:採購多交期匯總檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdq_t
(
pmdqent       number(5)      ,/* 企業編號 */
pmdqsite       varchar2(10)      ,/* 營運據點 */
pmdqdocno       varchar2(20)      ,/* 採購單號 */
pmdqseq       number(10,0)      ,/* 採購項次 */
pmdqseq2       number(10,0)      ,/* 分批序 */
pmdq002       number(20,6)      ,/* 分批數量 */
pmdq003       date      ,/* 交貨日期 */
pmdq004       date      ,/* 到廠日期 */
pmdq005       date      ,/* 到庫日期 */
pmdq006       varchar2(10)      ,/* 收貨時段 */
pmdq007       varchar2(1)      ,/* MRP凍結否 */
pmdq008       varchar2(10)      ,/* 交期類型 */
pmdq201       varchar2(10)      ,/* 分批包裝單位 */
pmdq202       number(20,6)      ,/* 分批包裝數量 */
pmdq900       number(20,6)      ,/* 保留欄位str */
pmdq999       number(20,6)      ,/* 保留欄位end */
pmdqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdq_t add constraint pmdq_pk primary key (pmdqent,pmdqdocno,pmdqseq,pmdqseq2) enable validate;

create unique index pmdq_pk on pmdq_t (pmdqent,pmdqdocno,pmdqseq,pmdqseq2);

grant select on pmdq_t to tiptop;
grant update on pmdq_t to tiptop;
grant delete on pmdq_t to tiptop;
grant insert on pmdq_t to tiptop;

exit;

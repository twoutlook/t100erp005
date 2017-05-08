/* 
================================================================================
檔案代號:stal_t
檔案名稱:自營合約異動申請單費用分段扣率設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stal_t
(
stalent       number(5)      ,/* 企業編號 */
staldocno       varchar2(20)      ,/* 單號 */
stalseq1       number(10,0)      ,/* 項次 */
stalseq2       number(10,0)      ,/* 項次2 */
stal004       number(20,6)      ,/* 起始金額 */
stal005       number(20,6)      ,/* 截止金額 */
stal006       number(20,6)      ,/* 扣率 */
stalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stalud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stal_t add constraint stal_pk primary key (stalent,staldocno,stalseq1,stalseq2) enable validate;

create unique index stal_pk on stal_t (stalent,staldocno,stalseq1,stalseq2);

grant select on stal_t to tiptop;
grant update on stal_t to tiptop;
grant delete on stal_t to tiptop;
grant insert on stal_t to tiptop;

exit;

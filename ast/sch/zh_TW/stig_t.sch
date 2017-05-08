/* 
================================================================================
檔案代號:stig_t
檔案名稱:招商租賃合約申請分段扣率單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stig_t
(
stigent       number(5)      ,/* 企業編號 */
stigsite       varchar2(10)      ,/* 營運組織 */
stigunit       varchar2(10)      ,/* 制定組織 */
stigdocno       varchar2(20)      ,/* 單據編號 */
stigseq       number(10,0)      ,/* 項次 */
stigseq1       number(10,0)      ,/* 项序 */
stig001       varchar2(20)      ,/* 合約編號 */
stig002       number(20,6)      ,/* 起始金額 */
stig003       number(20,6)      ,/* 截止金額 */
stig004       number(20,6)      ,/* 固定/單位金額 */
stig005       number(20,6)      ,/* 比例 */
stigud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stigud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stigud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stigud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stigud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stigud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stigud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stigud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stigud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stigud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stigud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stigud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stigud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stigud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stigud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stigud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stigud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stigud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stigud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stigud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stigud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stigud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stigud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stigud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stigud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stigud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stigud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stigud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stigud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stigud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stig006       number(20,6)      ,/* 確認金額 */
stig007       number(20,6)      /* 確認比例 */
);
alter table stig_t add constraint stig_pk primary key (stigent,stigdocno,stigseq,stigseq1) enable validate;

create unique index stig_pk on stig_t (stigent,stigdocno,stigseq,stigseq1);

grant select on stig_t to tiptop;
grant update on stig_t to tiptop;
grant delete on stig_t to tiptop;
grant insert on stig_t to tiptop;

exit;

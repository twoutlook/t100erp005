/* 
================================================================================
檔案代號:rtig_t
檔案名稱:銷售交易開立餘額券檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtig_t
(
rtigent       number(5)      ,/* 企業編號 */
rtigsite       varchar2(10)      ,/* 營運據點 */
rtigunit       varchar2(10)      ,/* 應用組織 */
rtigdocno       varchar2(20)      ,/* 單據編號 */
rtig001       varchar2(30)      ,/* 券號 */
rtig002       varchar2(10)      ,/* 券種編號 */
rtig003       number(20,6)      ,/* 券開立金額 */
rtigud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtigud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtigud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtigud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtigud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtigud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtigud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtigud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtigud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtigud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtigud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtigud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtigud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtigud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtigud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtigud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtigud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtigud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtigud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtigud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtigud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtigud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtigud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtigud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtigud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtigud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtigud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtigud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtigud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtigud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtig_t add constraint rtig_pk primary key (rtigent,rtigdocno,rtig001) enable validate;

create unique index rtig_pk on rtig_t (rtigent,rtigdocno,rtig001);

grant select on rtig_t to tiptop;
grant update on rtig_t to tiptop;
grant delete on rtig_t to tiptop;
grant insert on rtig_t to tiptop;

exit;

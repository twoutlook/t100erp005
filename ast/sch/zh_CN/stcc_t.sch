/* 
================================================================================
檔案代號:stcc_t
檔案名稱:分銷合約申請費用分段扣率設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcc_t
(
stccent       number(5)      ,/* 企業編號 */
stccsite       varchar2(10)      ,/* 營運據點 */
stccunit       varchar2(10)      ,/* 應用組織 */
stccdocno       varchar2(20)      ,/* 單據編號 */
stccseq1       number(10,0)      ,/* 項次1 */
stccseq2       number(10,0)      ,/* 項次2 */
stcc001       varchar2(20)      ,/* 合約編號 */
stcc002       number(20,6)      ,/* 起始金額 */
stcc003       number(20,6)      ,/* 截止金額 */
stcc004       number(20,6)      ,/* 扣率 */
stccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcc_t add constraint stcc_pk primary key (stccent,stccdocno,stccseq1,stccseq2) enable validate;

create unique index stcc_pk on stcc_t (stccent,stccdocno,stccseq1,stccseq2);

grant select on stcc_t to tiptop;
grant update on stcc_t to tiptop;
grant delete on stcc_t to tiptop;
grant insert on stcc_t to tiptop;

exit;

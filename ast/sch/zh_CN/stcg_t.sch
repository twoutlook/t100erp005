/* 
================================================================================
檔案代號:stcg_t
檔案名稱:分銷合約費用分段扣率設定主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcg_t
(
stcgent       number(5)      ,/* 企業編號 */
stcgsite       varchar2(10)      ,/* 營運據點 */
stcgunit       varchar2(10)      ,/* 應用組織 */
stcgseq1       number(10,0)      ,/* 項次1 */
stcgseq2       number(10,0)      ,/* 項次2 */
stcg001       varchar2(20)      ,/* 合約編號 */
stcg002       number(20,6)      ,/* 起始金額 */
stcg003       number(20,6)      ,/* 截止金額 */
stcg004       number(20,6)      ,/* 扣率 */
stcgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcg_t add constraint stcg_pk primary key (stcgent,stcgseq1,stcgseq2,stcg001) enable validate;

create unique index stcg_pk on stcg_t (stcgent,stcgseq1,stcgseq2,stcg001);

grant select on stcg_t to tiptop;
grant update on stcg_t to tiptop;
grant delete on stcg_t to tiptop;
grant insert on stcg_t to tiptop;

exit;

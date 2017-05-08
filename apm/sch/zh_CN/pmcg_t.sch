/* 
================================================================================
檔案代號:pmcg_t
檔案名稱:供應商評核定量項目分級得分設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmcg_t
(
pmcgent       number(5)      ,/* 企業編號 */
pmcg001       varchar2(10)      ,/* 評核期別 */
pmcg002       varchar2(10)      ,/* 評核品類 */
pmcg003       varchar2(10)      ,/* 定量評核項目 */
pmcg004       number(10,0)      ,/* 項次 */
pmcg005       number(20,6)      ,/* 佔比起 */
pmcg006       number(20,6)      ,/* 佔比起 */
pmcg007       number(15,3)      ,/* 得分 */
pmcgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmcg_t add constraint pmcg_pk primary key (pmcgent,pmcg001,pmcg002,pmcg003,pmcg004) enable validate;

create unique index pmcg_pk on pmcg_t (pmcgent,pmcg001,pmcg002,pmcg003,pmcg004);

grant select on pmcg_t to tiptop;
grant update on pmcg_t to tiptop;
grant delete on pmcg_t to tiptop;
grant insert on pmcg_t to tiptop;

exit;

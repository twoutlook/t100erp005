/* 
================================================================================
檔案代號:stil_t
檔案名稱:招商租賃合約申請单价收费项目單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stil_t
(
stilent       number(5)      ,/* 企業編號 */
stilsite       varchar2(10)      ,/* 營運組織 */
stilunit       varchar2(10)      ,/* 制定組織 */
stildocno       varchar2(20)      ,/* 單據編號 */
stilseq       number(10,0)      ,/* 項次 */
stil001       varchar2(20)      ,/* 合約編號 */
stil002       varchar2(10)      ,/* 費用類型 */
stil003       varchar2(10)      ,/* 費用編號 */
stil004       varchar2(1)      ,/* 納入結算單否 */
stil005       varchar2(1)      ,/* 票扣否 */
stil006       number(20,6)      ,/* 单价 */
stil007       number(20,6)      ,/* 優惠度數 */
stil008       number(20,6)      ,/* 優惠金額 */
stilud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stilud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stilud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stilud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stilud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stilud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stilud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stilud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stilud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stilud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stilud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stilud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stilud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stilud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stilud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stilud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stilud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stilud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stilud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stilud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stilud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stilud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stilud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stilud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stilud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stilud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stilud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stilud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stilud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stilud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stil_t add constraint stil_pk primary key (stilent,stildocno,stilseq) enable validate;

create unique index stil_pk on stil_t (stilent,stildocno,stilseq);

grant select on stil_t to tiptop;
grant update on stil_t to tiptop;
grant delete on stil_t to tiptop;
grant insert on stil_t to tiptop;

exit;

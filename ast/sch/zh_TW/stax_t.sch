/* 
================================================================================
檔案代號:stax_t
檔案名稱:供應商合約結算帳期資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stax_t
(
staxent       number(5)      ,/* 企業編號 */
staxsite       varchar2(10)      ,/* 營運據點 */
staxunit       varchar2(10)      ,/* 應用組織 */
staxseq       number(10,0)      ,/* 帳期 */
stax001       varchar2(20)      ,/* 合約編號 */
stax002       date      ,/* 起止日期 */
stax003       date      ,/* 截止日期 */
stax004       date      ,/* 結算日期 */
stax005       varchar2(1)      ,/* 結算否 */
stax006       varchar2(20)      ,/* 結算單號 */
staxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
staxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
staxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
staxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
staxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
staxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
staxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
staxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
staxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
staxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
staxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
staxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
staxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
staxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
staxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
staxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
staxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
staxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
staxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
staxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
staxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
staxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
staxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
staxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
staxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
staxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
staxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
staxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
staxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
staxud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stax007       varchar2(10)      /* 法人 */
);
alter table stax_t add constraint stax_pk primary key (staxent,staxseq,stax001,stax007) enable validate;

create unique index stax_pk on stax_t (staxent,staxseq,stax001,stax007);

grant select on stax_t to tiptop;
grant update on stax_t to tiptop;
grant delete on stax_t to tiptop;
grant insert on stax_t to tiptop;

exit;

/* 
================================================================================
檔案代號:stcw_t
檔案名稱:分銷合約申請結算帳期資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcw_t
(
stcwent       number(5)      ,/* 企業代碼 */
stcwsite       varchar2(10)      ,/* 營運據點 */
stcwunit       varchar2(10)      ,/* 應用組織 */
stcwseq       number(10,0)      ,/* 項次 */
stcw001       varchar2(20)      ,/* 合約編號 */
stcw002       date      ,/* 起止日期 */
stcw003       date      ,/* 截止日期 */
stcw004       date      ,/* 結算日期 */
stcw005       varchar2(1)      ,/* 結算否 */
stcw006       varchar2(20)      ,/* 結算單號 */
stcwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcw_t add constraint stcw_pk primary key (stcwent,stcwseq,stcw001) enable validate;

create unique index stcw_pk on stcw_t (stcwent,stcwseq,stcw001);

grant select on stcw_t to tiptop;
grant update on stcw_t to tiptop;
grant delete on stcw_t to tiptop;
grant insert on stcw_t to tiptop;

exit;

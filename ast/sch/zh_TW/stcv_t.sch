/* 
================================================================================
檔案代號:stcv_t
檔案名稱:分銷合約申請結算帳期資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcv_t
(
stcvent       number(5)      ,/* 企業編號 */
stcvsite       varchar2(10)      ,/* 營運據點 */
stcvunit       varchar2(10)      ,/* 應用組織 */
stcvdocno       varchar2(20)      ,/* 單據編號 */
stcvseq       number(10,0)      ,/* 帳期 */
stcv001       varchar2(20)      ,/* 合約編號 */
stcv002       date      ,/* 起止日期 */
stcv003       date      ,/* 截止日期 */
stcv004       date      ,/* 結算日期 */
stcv005       varchar2(1)      ,/* 結算否 */
stcv006       varchar2(20)      ,/* 結算單號 */
stcvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcv_t add constraint stcv_pk primary key (stcvent,stcvdocno,stcvseq) enable validate;

create unique index stcv_pk on stcv_t (stcvent,stcvdocno,stcvseq);

grant select on stcv_t to tiptop;
grant update on stcv_t to tiptop;
grant delete on stcv_t to tiptop;
grant insert on stcv_t to tiptop;

exit;

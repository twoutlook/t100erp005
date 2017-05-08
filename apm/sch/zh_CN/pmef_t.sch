/* 
================================================================================
檔案代號:pmef_t
檔案名稱:採購變更多帳期預付款檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmef_t
(
pmefent       number(5)      ,/* 企業編號 */
pmefsite       varchar2(10)      ,/* 營運據點 */
pmefdocno       varchar2(20)      ,/* 採購變更單號 */
pmef001       number(5,0)      ,/* 期別 */
pmef002       varchar2(10)      ,/* 付款條件 */
pmef003       date      ,/* 預計應付款日 */
pmef004       date      ,/* 預計票據到期日 */
pmef005       number(20,6)      ,/* 未稅金額 */
pmef006       number(20,6)      ,/* 含稅金額 */
pmef007       varchar2(20)      ,/* 應付帳款單號 */
pmef008       number(20,6)      ,/* 主帳套立帳未稅金額 */
pmef009       number(20,6)      ,/* 主帳套立帳含稅金額 */
pmef010       number(20,6)      ,/* 帳套二立帳未稅金額 */
pmef011       number(20,6)      ,/* 帳套二立帳含稅金額 */
pmef012       number(20,6)      ,/* 帳套三立帳未稅金額 */
pmef013       number(20,6)      ,/* 帳套三立帳含稅金額 */
pmef014       varchar2(10)      ,/* 帳款類型 */
pmef900       number(10,0)      ,/* 變更序 */
pmef901       varchar2(1)      ,/* 變更類型 */
pmef902       varchar2(10)      ,/* 變更理由 */
pmef903       varchar2(255)      ,/* 變更備註 */
pmefud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmefud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmefud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmefud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmefud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmefud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmefud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmefud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmefud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmefud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmefud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmefud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmefud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmefud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmefud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmefud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmefud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmefud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmefud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmefud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmefud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmefud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmefud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmefud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmefud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmefud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmefud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmefud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmefud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmefud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmef_t add constraint pmef_pk primary key (pmefent,pmefdocno,pmef001,pmef900) enable validate;

create unique index pmef_pk on pmef_t (pmefent,pmefdocno,pmef001,pmef900);

grant select on pmef_t to tiptop;
grant update on pmef_t to tiptop;
grant delete on pmef_t to tiptop;
grant insert on pmef_t to tiptop;

exit;

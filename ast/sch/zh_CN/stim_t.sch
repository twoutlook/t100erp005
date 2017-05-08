/* 
================================================================================
檔案代號:stim_t
檔案名稱:招商租賃合約申請合約帳期單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stim_t
(
stiment       number(5)      ,/* 企業編號 */
stimsite       varchar2(10)      ,/* 營運組織 */
stimunit       varchar2(10)      ,/* 制定組織 */
stimdocno       varchar2(20)      ,/* 單據編號 */
stimseq       number(10,0)      ,/* 項次 */
stim001       varchar2(20)      ,/* 合約編號 */
stim002       number(5,0)      ,/* 結算帳期 */
stim003       varchar2(10)      ,/* 費用編號 */
stim004       date      ,/* 岀帳日期 */
stim005       date      ,/* 起始日期 */
stim006       date      ,/* 截止日期 */
stim007       number(20,6)      ,/* 標準費用 */
stim008       number(20,6)      ,/* 優惠費用 */
stim009       number(20,6)      ,/* 抹零金額 */
stim010       number(20,6)      ,/* 終止費用 */
stim011       number(20,6)      ,/* 實際應收 */
stim012       number(20,6)      ,/* 已收金額 */
stim013       number(20,6)      ,/* 未收金額 */
stim014       number(20,6)      ,/* 清算金額 */
stim015       varchar2(1)      ,/* 結案否 */
stim016       varchar2(20)      ,/* 費用單號 */
stim017       varchar2(10)      ,/* 合約版本 */
stimud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stimud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stimud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stimud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stimud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stimud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stimud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stimud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stimud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stimud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stimud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stimud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stimud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stimud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stimud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stimud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stimud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stimud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stimud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stimud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stimud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stimud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stimud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stimud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stimud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stimud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stimud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stimud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stimud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stimud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stim018       varchar2(10)      ,/* 費用歸屬類型 */
stim019       varchar2(10)      /* 費用歸屬組織 */
);
alter table stim_t add constraint stim_pk primary key (stiment,stimdocno,stimseq) enable validate;

create unique index stim_pk on stim_t (stiment,stimdocno,stimseq);

grant select on stim_t to tiptop;
grant update on stim_t to tiptop;
grant delete on stim_t to tiptop;
grant insert on stim_t to tiptop;

exit;

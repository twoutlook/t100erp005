/* 
================================================================================
檔案代號:fmmx_t
檔案名稱:收息賬務單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmmx_t
(
fmmxent       number(5)      ,/* 企業代碼 */
fmmxdocno       varchar2(20)      ,/* 單號 */
fmmxseq       number(10,0)      ,/* 項次 */
fmmx001       varchar2(10)      ,/* 投資組織 */
fmmx002       varchar2(20)      ,/* 收息單號 */
fmmx003       varchar2(1)      ,/* 來源 */
fmmx004       number(10,0)      ,/* 收支方式 */
fmmx005       varchar2(10)      ,/* 收息銀行 */
fmmx006       varchar2(10)      ,/* 帳款對象 */
fmmx007       varchar2(10)      ,/* 收款對象 */
fmmx008       varchar2(10)      ,/* 部門 */
fmmx009       varchar2(10)      ,/* 利潤中心 */
fmmx010       varchar2(10)      ,/* 區域 */
fmmx011       varchar2(10)      ,/* 客群 */
fmmx012       varchar2(10)      ,/* 產品類別 */
fmmx013       varchar2(20)      ,/* 人員 */
fmmx014       varchar2(10)      ,/* 專案代號 */
fmmx015       varchar2(30)      ,/* WBS編號 */
fmmx016       varchar2(10)      ,/* 經營方式 */
fmmx017       varchar2(10)      ,/* 渠道 */
fmmx018       varchar2(10)      ,/* 品牌 */
fmmx019       varchar2(30)      ,/* 自由核算項一 */
fmmx020       varchar2(30)      ,/* 自由核算項二 */
fmmx021       varchar2(30)      ,/* 自由核算項三 */
fmmx022       varchar2(30)      ,/* 自由核算項四 */
fmmx023       varchar2(30)      ,/* 自由核算項五 */
fmmx024       varchar2(30)      ,/* 自由核算項六 */
fmmx025       varchar2(30)      ,/* 自由核算項七 */
fmmx026       varchar2(30)      ,/* 自由核算項八 */
fmmx027       varchar2(30)      ,/* 自由核算項九 */
fmmx028       varchar2(30)      ,/* 自由核算項十 */
fmmx029       varchar2(24)      ,/* 會計科目 */
fmmx030       varchar2(24)      ,/* 利息費用科目 */
fmmx100       varchar2(10)      ,/* 幣別 */
fmmx101       number(20,6)      ,/* 原幣金額 */
fmmx111       number(20,10)      ,/* 匯率一 */
fmmx112       number(20,6)      ,/* 本幣一 */
fmmx121       number(20,10)      ,/* 匯率二 */
fmmx122       number(20,6)      ,/* 本幣二 */
fmmx131       number(20,10)      ,/* 匯率三 */
fmmx132       number(20,6)      ,/* 本幣三 */
fmmx133       varchar2(255)      ,/* 摘要 */
fmmxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmxud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmx031       varchar2(10)      ,/* 現金變動碼 */
fmmx032       varchar2(10)      ,/* 存提碼 */
fmmx033       varchar2(24)      ,/* 對方科目 */
fmmx102       number(20,6)      ,/* 利息/費用原幣 */
fmmx103       number(20,10)      ,/* 匯率 */
fmmx104       number(20,6)      ,/* 利息/費用本幣 */
fmmx105       number(20,6)      ,/* 收入原幣 */
fmmx106       number(20,10)      ,/* 匯率 */
fmmx107       number(20,6)      ,/* 收入本幣 */
fmmx108       number(20,6)      /* 匯差金額 */
);
alter table fmmx_t add constraint fmmx_pk primary key (fmmxent,fmmxdocno,fmmxseq) enable validate;

create unique index fmmx_pk on fmmx_t (fmmxent,fmmxdocno,fmmxseq);

grant select on fmmx_t to tiptop;
grant update on fmmx_t to tiptop;
grant delete on fmmx_t to tiptop;
grant insert on fmmx_t to tiptop;

exit;

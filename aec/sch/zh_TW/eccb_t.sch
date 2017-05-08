/* 
================================================================================
檔案代號:eccb_t
檔案名稱:料件製程變更單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table eccb_t
(
eccbent       number(5)      ,/* 企業代碼 */
eccbsite       varchar2(10)      ,/* 營運據點 */
eccbdocno       varchar2(20)      ,/* 申請單號 */
eccb001       varchar2(40)      ,/* 製程料號 */
eccb002       varchar2(10)      ,/* 製程編號 */
eccb003       number(10,0)      ,/* 項次 */
eccb004       varchar2(10)      ,/* 本站作業 */
eccb005       varchar2(10)      ,/* 作業序 */
eccb006       varchar2(1)      ,/* 群組性質 */
eccb007       varchar2(10)      ,/* 群組 */
eccb008       varchar2(10)      ,/* 上站作業 */
eccb009       varchar2(10)      ,/* 上站作業序 */
eccb010       varchar2(10)      ,/* 下站作業 */
eccb011       varchar2(10)      ,/* 下站作業序 */
eccb012       varchar2(10)      ,/* 工作站 */
eccb013       varchar2(1)      ,/* 允許委外 */
eccb014       varchar2(10)      ,/* 主要加工廠 */
eccb015       varchar2(1)      ,/* Move in */
eccb016       varchar2(1)      ,/* Check in */
eccb017       varchar2(1)      ,/* 報工站 */
eccb018       varchar2(1)      ,/* PQC */
eccb019       varchar2(1)      ,/* Check out */
eccb020       varchar2(1)      ,/* Move out */
eccb021       varchar2(10)      ,/* 轉出單位 */
eccb022       number(20,6)      ,/* 轉出單位轉換率分子 */
eccb023       number(20,6)      ,/* 轉出單位轉換率分母 */
eccb024       number(15,3)      ,/* 固定工時 */
eccb025       number(15,3)      ,/* 標準工時 */
eccb026       number(15,3)      ,/* 固定機時 */
eccb027       number(15,3)      ,/* 標準機時 */
eccb028       number(20,6)      ,/* 完成度 */
eccb029       number(20,6)      ,/* 標準單價 */
eccb030       varchar2(10)      ,/* 轉入單位 */
eccb031       number(20,6)      ,/* 轉入單位轉換分子 */
eccb032       number(20,6)      ,/* 轉入單位轉換分母 */
eccb033       varchar2(1)      ,/* 回收站 */
eccb034       number(5,0)      ,/* 後置時間 */
eccb035       number(5,0)      ,/* X軸 */
eccb036       number(5,0)      ,/* Y軸 */
eccb900       number(10,0)      ,/* 變更序 */
eccb901       varchar2(1)      ,/* 變更類型 */
eccb902       date      ,/* 變更日期 */
eccb905       varchar2(10)      ,/* 變更理由 */
eccb906       varchar2(255)      ,/* 變更備註 */
eccbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
eccbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
eccbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
eccbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
eccbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
eccbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
eccbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
eccbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
eccbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
eccbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
eccbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
eccbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
eccbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
eccbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
eccbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
eccbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
eccbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
eccbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
eccbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
eccbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
eccbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
eccbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
eccbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
eccbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
eccbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
eccbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
eccbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
eccbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
eccbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
eccbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table eccb_t add constraint eccb_pk primary key (eccbent,eccbsite,eccbdocno,eccb003) enable validate;

create unique index eccb_pk on eccb_t (eccbent,eccbsite,eccbdocno,eccb003);

grant select on eccb_t to tiptop;
grant update on eccb_t to tiptop;
grant delete on eccb_t to tiptop;
grant insert on eccb_t to tiptop;

exit;

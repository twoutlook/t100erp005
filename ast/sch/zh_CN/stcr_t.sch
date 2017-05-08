/* 
================================================================================
檔案代號:stcr_t
檔案名稱:分銷客戶陳列協議條款明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcr_t
(
stcrent       number(5)      ,/* 企業編號 */
stcrunit       varchar2(10)      ,/* 應用組織 */
stcrsite       varchar2(10)      ,/* 營運據點 */
stcrdocno       varchar2(20)      ,/* 單據編號 */
stcrseq       number(10,0)      ,/* 項次 */
stcr001       varchar2(10)      ,/* 費用編號 */
stcr002       varchar2(10)      ,/* 幣別 */
stcr003       varchar2(10)      ,/* 稅別 */
stcr004       varchar2(10)      ,/* 價款類別 */
stcr005       varchar2(10)      ,/* 費用週期 */
stcr006       varchar2(10)      ,/* 週期方式 */
stcr007       date      ,/* 起始日期 */
stcr008       date      ,/* 截止日期 */
stcr009       number(20,6)      ,/* 費用金額 */
stcr010       date      ,/* 下次計算日 */
stcr011       varchar2(10)      ,/* 對象類型 */
stcr012       varchar2(10)      ,/* 經銷商 */
stcr013       varchar2(10)      ,/* 網點 */
stcr014       varchar2(10)      ,/* 經銷方式 */
stcr015       varchar2(10)      ,/* 結算類型 */
stcr016       varchar2(10)      ,/* 結算方式 */
stcr017       varchar2(10)      ,/* 銷售組織 */
stcr018       varchar2(10)      ,/* 銷售範圍 */
stcr019       varchar2(10)      ,/* 銷售渠道 */
stcr020       varchar2(10)      ,/* 產品組 */
stcr021       varchar2(10)      ,/* 辦事處 */
stcr022       varchar2(80)      ,/* 備註 */
stcr023       date      ,/* 下次費用起始日 */
stcr024       date      ,/* 下次費用截止日 */
stcrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcr_t add constraint stcr_pk primary key (stcrent,stcrdocno,stcrseq) enable validate;

create unique index stcr_pk on stcr_t (stcrent,stcrdocno,stcrseq);

grant select on stcr_t to tiptop;
grant update on stcr_t to tiptop;
grant delete on stcr_t to tiptop;
grant insert on stcr_t to tiptop;

exit;

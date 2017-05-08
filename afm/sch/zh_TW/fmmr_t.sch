/* 
================================================================================
檔案代號:fmmr_t
檔案名稱: 公允價值調整帳務單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmmr_t
(
fmmrent       number(5)      ,/* 企業編號 */
fmmrdocno       varchar2(20)      ,/* 單據編號 */
fmmrseq       number(10,0)      ,/* 項次 */
fmmr001       varchar2(10)      ,/* 投資組織 */
fmmr002       varchar2(20)      ,/* 投資單號 */
fmmr003       varchar2(10)      ,/* 幣別 */
fmmr004       number(20,6)      ,/* 價值變動差額 */
fmmr005       number(20,10)      ,/* 匯率一 */
fmmr006       number(20,6)      ,/* 本幣一 */
fmmr007       number(20,10)      ,/* 匯率二 */
fmmr008       number(20,6)      ,/* 本幣二 */
fmmr009       number(20,10)      ,/* 匯率三 */
fmmr010       number(20,6)      ,/* 本幣三 */
fmmr011       varchar2(24)      ,/* 公允價值變動科目 */
fmmr012       varchar2(24)      ,/* 公允價值損益科目 */
fmmr013       varchar2(10)      ,/* 帳款對象 */
fmmr014       varchar2(10)      ,/* 收款對象 */
fmmr015       varchar2(10)      ,/* 部門 */
fmmr016       varchar2(10)      ,/* 責任中心 */
fmmr017       varchar2(10)      ,/* 區域 */
fmmr018       varchar2(10)      ,/* 客群 */
fmmr019       varchar2(10)      ,/* 產品類別 */
fmmr020       varchar2(20)      ,/* 人員 */
fmmr021       varchar2(20)      ,/* 專案代號 */
fmmr022       varchar2(30)      ,/* WBS編號 */
fmmr023       varchar2(10)      ,/* 經營方式 */
fmmr024       varchar2(10)      ,/* 渠道 */
fmmr025       varchar2(10)      ,/* 品牌 */
fmmr026       varchar2(30)      ,/* 自由核算項一 */
fmmr027       varchar2(30)      ,/* 自由核算項二 */
fmmr028       varchar2(30)      ,/* 自由核算項三 */
fmmr029       varchar2(30)      ,/* 自由核算項四 */
fmmr030       varchar2(30)      ,/* 自由核算項五 */
fmmr031       varchar2(30)      ,/* 自由核算項六 */
fmmr032       varchar2(30)      ,/* 自由核算項七 */
fmmr033       varchar2(30)      ,/* 自由核算項八 */
fmmr034       varchar2(30)      ,/* 自由核算項九 */
fmmr035       varchar2(30)      ,/* 自由核算項十 */
fmmr036       varchar2(255)      ,/* 摘要 */
fmmrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmrud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmr037       number(20,6)      /* 期末公允價值本幣金額 */
);
alter table fmmr_t add constraint fmmr_pk primary key (fmmrent,fmmrdocno,fmmrseq) enable validate;

create unique index fmmr_pk on fmmr_t (fmmrent,fmmrdocno,fmmrseq);

grant select on fmmr_t to tiptop;
grant update on fmmr_t to tiptop;
grant delete on fmmr_t to tiptop;
grant insert on fmmr_t to tiptop;

exit;

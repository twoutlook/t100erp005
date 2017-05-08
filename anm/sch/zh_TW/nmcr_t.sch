/* 
================================================================================
檔案代號:nmcr_t
檔案名稱:應收票據異動明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmcr_t
(
nmcrent       number(5)      ,/* 企業編碼 */
nmcrcomp       varchar2(10)      ,/* 法人 */
nmcrdocno       varchar2(20)      ,/* 單據號碼 */
nmcrseq       number(10,0)      ,/* 項次 */
nmcrorga       varchar2(10)      ,/* 來源組織 */
nmcr001       varchar2(20)      ,/* 票據號碼 */
nmcr002       varchar2(1)      ,/* 票況 */
nmcr003       varchar2(20)      ,/* 開票單號 */
nmcr004       number(5,0)      ,/* 流通期間 */
nmcr005       varchar2(1)      ,/* 貼現利率種類 */
nmcr006       number(10,6)      ,/* 貼現率 */
nmcr007       number(5,0)      ,/* 貼現期間 */
nmcr008       varchar2(20)      ,/* 重立帳單號 */
nmcr100       varchar2(10)      ,/* 幣別 */
nmcr101       number(20,10)      ,/* 匯率 */
nmcr103       number(20,6)      ,/* 原幣異動金額 */
nmcr104       number(20,6)      ,/* 原幣利息收入 */
nmcr105       number(20,6)      ,/* 原幣貼現息 */
nmcr106       number(20,6)      ,/* 原幣銀行撥入 */
nmcr107       number(20,6)      ,/* 原幣手續費 */
nmcr113       number(20,6)      ,/* 本幣異動金額 */
nmcr114       number(20,6)      ,/* 本幣利息收入 */
nmcr115       number(20,6)      ,/* 本幣貼現息 */
nmcr116       number(20,6)      ,/* 本幣銀行撥入 */
nmcr117       number(20,6)      ,/* 本幣手續費 */
nmcr118       number(20,6)      ,/* 本幣匯差 */
nmcr121       number(20,10)      ,/* 本位幣二匯率 */
nmcr122       number(20,6)      ,/* 本位幣二匯差 */
nmcr131       number(20,10)      ,/* 本位幣三匯率 */
nmcr132       number(20,6)      ,/* 本位幣三匯差 */
nmcrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcr_t add constraint nmcr_pk primary key (nmcrent,nmcrcomp,nmcrdocno,nmcrseq) enable validate;

create unique index nmcr_pk on nmcr_t (nmcrent,nmcrcomp,nmcrdocno,nmcrseq);

grant select on nmcr_t to tiptop;
grant update on nmcr_t to tiptop;
grant delete on nmcr_t to tiptop;
grant insert on nmcr_t to tiptop;

exit;

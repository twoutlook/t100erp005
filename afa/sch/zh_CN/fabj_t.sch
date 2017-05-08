/* 
================================================================================
檔案代號:fabj_t
檔案名稱:利息資本化明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabj_t
(
fabjent       number(5)      ,/* 企業編號 */
fabjcomp       varchar2(10)      ,/* 法人 */
fabjdocno       varchar2(20)      ,/* 單據編號 */
fabjseq       number(10,0)      ,/* 項次 */
fabj000       number(10)      ,/* 異動類型 */
fabj001       varchar2(20)      ,/* 底稿編號 */
fabj002       varchar2(20)      ,/* 附號 */
fabj003       varchar2(10)      ,/* 卡片編號 */
fabj004       varchar2(1)      ,/* 來源 */
fabj005       varchar2(10)      ,/* 單位 */
fabj006       number(20,6)      ,/* 數量 */
fabj007       varchar2(20)      ,/* 來源單號 */
fabj008       number(10,0)      ,/* 來源項次 */
fabj009       number(20,6)      ,/* 利率 */
fabj010       varchar2(10)      ,/* 幣別 */
fabj011       number(20,10)      ,/* 匯率 */
fabj012       number(20,6)      ,/* 原幣金額 */
fabj013       number(20,6)      ,/* 本幣金額 */
fabj014       date      ,/* 轉固定資產日期 */
fabj015       varchar2(10)      ,/* 原因碼 */
fabj016       varchar2(20)      ,/* 費用編號 */
fabj017       varchar2(10)      ,/* 產生卡片編號 */
fabjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabj_t add constraint fabj_pk primary key (fabjent,fabjdocno,fabjseq) enable validate;

create unique index fabj_pk on fabj_t (fabjent,fabjdocno,fabjseq);

grant select on fabj_t to tiptop;
grant update on fabj_t to tiptop;
grant delete on fabj_t to tiptop;
grant insert on fabj_t to tiptop;

exit;

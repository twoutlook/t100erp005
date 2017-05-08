/* 
================================================================================
檔案代號:xrce_t
檔案名稱:應收沖銷明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrce_t
(
xrceent       number(5)      ,/* 企業編號 */
xrcecomp       varchar2(10)      ,/* 法人 */
xrceld       varchar2(5)      ,/* 帳套 */
xrcedocno       varchar2(20)      ,/* 沖銷單單號 */
xrceseq       number(10,0)      ,/* 項次 */
xrcelegl       varchar2(10)      ,/* no use */
xrcesite       varchar2(10)      ,/* 帳務中心 */
xrceorga       varchar2(10)      ,/* 帳務歸屬組織 */
xrce001       varchar2(10)      ,/* 來源作業 */
xrce002       varchar2(10)      ,/* 沖銷類型 */
xrce003       varchar2(20)      ,/* 沖銷帳款單單號 */
xrce004       number(10,0)      ,/* 沖銷帳款單項次 */
xrce005       number(10,0)      ,/* 沖銷帳款單帳期 */
xrce006       varchar2(20)      ,/* no use */
xrce007       number(20,6)      ,/* no use */
xrce008       varchar2(20)      ,/* no use */
xrce009       varchar2(1)      ,/* no use */
xrce010       varchar2(255)      ,/* 摘要說明 */
xrce011       varchar2(10)      ,/* no use */
xrce012       varchar2(10)      ,/* no use */
xrce013       varchar2(10)      ,/* no use */
xrce014       varchar2(20)      ,/* no use */
xrce015       varchar2(1)      ,/* 沖銷加減項 */
xrce016       varchar2(24)      ,/* 沖銷科目 */
xrce017       varchar2(20)      ,/* 業務人員 */
xrce018       varchar2(10)      ,/* 業務部門 */
xrce019       varchar2(10)      ,/* 責任中心 */
xrce020       varchar2(10)      ,/* 產品類別 */
xrce021       varchar2(10)      ,/* no use */
xrce022       varchar2(20)      ,/* 專案編號 */
xrce023       varchar2(30)      ,/* WBS編號 */
xrce024       varchar2(20)      ,/* 第二參考單號 */
xrce025       number(10,0)      ,/* 第二參考單號項次 */
xrce026       varchar2(10)      ,/* no use */
xrce027       varchar2(1)      ,/* 應稅折抵否 */
xrce028       varchar2(1)      ,/* 產生方式 */
xrce029       varchar2(20)      ,/* 傳票號碼 */
xrce030       number(10,0)      ,/* 傳票項次 */
xrce035       varchar2(10)      ,/* 區域 */
xrce036       varchar2(10)      ,/* 客戶分類 */
xrce037       varchar2(10)      ,/* no use */
xrce038       varchar2(10)      ,/* 對象 */
xrce039       varchar2(10)      ,/* 經營方式 */
xrce040       varchar2(10)      ,/* 通路 */
xrce041       varchar2(10)      ,/* 品牌 */
xrce042       varchar2(30)      ,/* 自由核算項一 */
xrce043       varchar2(30)      ,/* 自由核算項二 */
xrce044       varchar2(30)      ,/* 自由核算項三 */
xrce045       varchar2(30)      ,/* 自由核算項四 */
xrce046       varchar2(30)      ,/* 自由核算項五 */
xrce047       varchar2(30)      ,/* 自由核算項六 */
xrce048       varchar2(30)      ,/* 自由核算項七 */
xrce049       varchar2(30)      ,/* 自由核算項八 */
xrce050       varchar2(30)      ,/* 自由核算項九 */
xrce051       varchar2(30)      ,/* 自由核算項十 */
xrce053       varchar2(20)      ,/* 發票代碼 */
xrce054       varchar2(20)      ,/* 發票號碼 */
xrce100       varchar2(10)      ,/* 幣別 */
xrce101       number(20,10)      ,/* 匯率 */
xrce104       number(20,6)      ,/* 原幣應稅折抵稅額 */
xrce109       number(20,6)      ,/* 原幣沖帳金額 */
xrce114       number(20,6)      ,/* 本幣應稅折抵稅額 */
xrce119       number(20,6)      ,/* 本幣沖帳金額 */
xrce120       varchar2(10)      ,/* 本位幣二幣別 */
xrce121       number(20,10)      ,/* 本位幣二匯率 */
xrce124       number(20,6)      ,/* 本位幣二應稅折抵稅額 */
xrce129       number(20,6)      ,/* 本位幣二沖帳金額 */
xrce130       varchar2(10)      ,/* 本位幣二幣別 */
xrce131       number(20,10)      ,/* 本位幣三匯率 */
xrce134       number(20,6)      ,/* 本位幣三應稅折抵稅額 */
xrce139       number(20,6)      ,/* 本位幣三沖帳金額 */
xrceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrceud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xrce055       varchar2(10)      ,/* 費用編號 */
xrce056       number(5,0)      ,/* 方向 */
xrce057       varchar2(20)      ,/* 預收待抵單號 */
xrce058       varchar2(20)      ,/* 應付單號 */
xrce103       number(20,6)      ,/* 未稅原幣沖銷額 */
xrce113       number(20,6)      ,/* 未稅本幣沖銷額 */
xrce123       number(20,6)      ,/* 本位幣二未稅沖銷額 */
xrce133       number(20,6)      ,/* 本位幣三未稅沖銷額 */
xrce059       varchar2(20)      /* 預收單號 */
);
alter table xrce_t add constraint xrce_pk primary key (xrceent,xrceld,xrcedocno,xrceseq) enable validate;

create  index xrce_01 on xrce_t (xrce001,xrce003,xrce004,xrce005);
create  index xrce_02 on xrce_t (xrce002,xrce006,xrce008,xrce009);
create  index xrce_03 on xrce_t (xrce015,xrce016);
create  index xrce_04 on xrce_t (xrce024,xrce025);
create  index xrce_n1 on xrce_t (xrceent,xrceld,xrce003,xrce004,xrce005);
create unique index xrce_pk on xrce_t (xrceent,xrceld,xrcedocno,xrceseq);

grant select on xrce_t to tiptop;
grant update on xrce_t to tiptop;
grant delete on xrce_t to tiptop;
grant insert on xrce_t to tiptop;

exit;
